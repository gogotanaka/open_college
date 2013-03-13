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
        @user.name = ""

        if University.find_by_name(user_info[2])
          @user.university_id = University.find_by_name(user_info[2]).id
        else 
          university = University.new
          university.name = user_info[2]
          university.save
          @user.university_id = university.id
        end

        if Department.find_by_name(user_info[4])
          @user.department_id = Department.find_by_name(user_info[4]).id
        else
          department = Department.new
          department.name = user_info[4]
          department.university_id = @user.university_id
          department.save
          @user.department_id = department.id
        end

        if SchoolSubject.find_by_name(user_info[5])
          @user.school_subject_id = SchoolSubject.find_by_name(user_info[5]).id
        else
          school_subject = SchoolSubject.new
          school_subject.name = user_info[5]
          school_subject.department_id = @user.department_id
          school_subject.save
          @user.school_subject_id = school_subject.id
        end 
        @user.school_year = user_info[6].gsub(/[^0-9]/,"").to_i

        table = doc.css('table.User')[1]
        table.xpath('.//tr').each do |node|
          if node.xpath('.//th').any?
          else
            if node.xpath('.//td').count == 1 || node.xpath('.//td').count == 2
            else
              nbsp = Nokogiri::HTML("&nbsp;").text
              analyze_class_name = node.xpath('.//td')[0].text.gsub(nbsp, "")
              find_class_year = ClassRoomForYear.find_by_name(analyze_class_name)
              if find_class_year
                find_class = find_class_year.class_rooms.find_by_year(node.xpath('.//td')[5].text.to_i)
                if find_class
                  if @user.taking?(find_class)
                  else
                    @user.take!(find_class)
                  end
                  if @user.value?(find_class)
                  else
                    @user.value!(find_class, node.xpath('.//td')[2].text)
                  end
                else
                  new_class_room = ClassRoom.new
                  new_class_room.class_room_for_year_id = find_class_year.id
                  new_class_room.year = node.xpath('.//td')[5].text.to_i
                  new_class_room.save
                  @user.take!(new_class_room)
                  @user.value!(new_class_room, node.xpath('.//td')[2].text)
                end
              else
                analyze_class_room_for_year = ClassRoomForYear.new
                analyze_class_room_for_year.name = analyze_class_name
                analyze_class_room_for_year.university_id = @user.university_id
                analyze_class_room_for_year.teacher_name = node.xpath('.//td')[1].text
                analyze_class_room_for_year.save
                new_class_room = ClassRoom.new
                new_class_room.class_room_for_year_id = analyze_class_room_for_year.id
                new_class_room.year = node.xpath('.//td')[5].text.to_i
                new_class_room.save
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