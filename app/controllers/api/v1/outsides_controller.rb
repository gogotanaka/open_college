module Api
  module V1
    class OutsidesController < ApplicationController

      before_filter :allow_cross_domain_access, :restrict_access

      respond_to :json

      def analyze
        @user = User.find_by_access_token(params[:access_token])
        scripts = params[:scripts]
        doc = Nokogiri::HTML(scripts)
        user_info = doc.xpath('//table/tbody/tr')[0].text.split

        @user.university = University.find_by_name(user_info[2]) ? University.find_by_name(user_info[2]) : University.create(name: user_info[2])
        @user.department = Department.find_by_name(user_info[4]) ? Department.find_by_name(user_info[4]) : @user.university.departments.create(name: user_info[4])
        @user.school_subject = SchoolSubject.find_by_name(user_info[5]) ? SchoolSubject.find_by_name(user_info[5]) : @user.department.school_subjects.create(name: user_info[5])
        @user.school_year = user_info[6].gsub(/[^0-9]/,"").to_i

        user_decision = doc.css('table.User')[0].xpath('.//td').text
        @user.play = user_decision
        table = doc.css('table.User')[1]
        table.xpath('.//tr').each do |node|
          unless node.xpath('.//th').any?
            unless node.xpath('.//td').count == 1 || node.xpath('.//td').count == 2
              nbsp = Nokogiri::HTML("&nbsp;").text
              analyze_class_name = node.xpath('.//td')[0].text.gsub(nbsp, "")
              find_class_year = ClassRoomForYear.find_by_name_and_teacher_name(analyze_class_name, node.xpath('.//td')[1].text)
              if find_class_year
                find_class = find_class_year.class_rooms.find_by_year(node.xpath('.//td')[5].text.to_i)
                if find_class
                  @user.take!(find_class) unless @user.taking?(find_class)
                  @user.value!(find_class, node.xpath('.//td')[2].text) unless @user.value?(find_class)
                else
                  new_class_room = find_class_year.class_rooms.create(year: node.xpath('.//td')[5].text.to_i)
                  @user.take!(new_class_room)
                  @user.value!(new_class_room, node.xpath('.//td')[2].text)
                end
              else
                analyze_class_room_for_year = @user.university.class_room_for_years.create(name: analyze_class_name)

                find_teacher = Teacher.find_by_name(node.xpath('.//td')[1].text)
                analyze_class_room_for_year.teacher = find_teacher ? find_teacher : Teacher.create(name: node.xpath('.//td')[1].text)

                analyze_class_room_for_year.teacher_name = node.xpath('.//td')[1].text
                analyze_class_room_for_year.save
                new_class_room = analyze_class_room_for_year.class_rooms.create(year: node.xpath('.//td')[5].text.to_i)
                @user.take!(new_class_room)
                @user.value!(new_class_room, node.xpath('.//td')[2].text)
              end
            end
          end
        end

        @user.save
        sign_in @user
        respond_with @user
      end

      private

        def restrict_access
          api_key = User.find_by_access_token(params[:access_token])
          head :unauthorized unless api_key
        end

        def allow_cross_domain_access
          response.headers["Access-Control-Allow-Origin"] = "https://www2.adst.keio.ac.jp"
          response.headers["Access-Control-Allow-Headers"] = "Content-Type"
          response.headers["Access-Control-Allow-Methods"] = "PUT,DELETE,POST,GET,OPTIONS"
        end

    end
  end
end