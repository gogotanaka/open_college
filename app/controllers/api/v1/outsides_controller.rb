module Api
  module V1
    class OutsidesController < ApplicationController

      before_filter :allow_cross_domain_access, :restrict_access

      respond_to :json

      def analyze
        @user = User.find_by_access_token(params[:access_token])
        scripts = params[:scripts]
        @user.html = params[:scripts]
        @user.save
        doc = Nokogiri::HTML(scripts)
        user_info = doc.xpath('//table/tbody/tr')[0].text.split

        @user.university = University.find_by_name(user_info[2]) ? University.find_by_name(user_info[2]) : University.create(name: user_info[2])
        @user.department = Department.find_by_name(user_info[4]) ? Department.find_by_name(user_info[4]) : @user.university.departments.create(name: user_info[4])
        @user.school_subject = SchoolSubject.find_by_name(user_info[5]) ? SchoolSubject.find_by_name(user_info[5]) : @user.department.school_subjects.create(name: user_info[5])
        @user.school_year = user_info[6].gsub(/[^0-9]/,"").to_i

        user_decision = doc.css('table.User')[0].css('td').text
        @user.play = user_decision
        table = doc.css('table.User')[1]
        table.css('tr').each do |node|
          tds = node.css('td')
          unless node.css('th').any?
            unless tds.count == 1 || tds.count == 2
              nbsp = Nokogiri::HTML("&nbsp;").text
              class_name, teacher_name, value, year = tds[0].text.gsub(nbsp, ""), tds[1].text, tds[2].text, tds[5].text.to_i
              teacher = Teacher.find_by_name(teacher_name)
              if teacher
                class_year = teacher.class_room_for_years.find_by_name(class_name)
                if class_year
                  class_room = class_year.class_rooms.find_by_year(year) ? class_year.class_rooms.find_by_year(year) : class_year.class_rooms.create(year: year)
                else
                  class_year = @user.university.class_room_for_years.create(name: class_name, :teacher_id: teacher.id)
                  class_room = class_year.class_rooms.create(year: year)
                end
              else
                teacher = Teacher.create(name: teacher_name)
                class_year = @user.university.class_room_for_years.create(name: class_name, :teacher_id: teacher.id)
                class_room = class_year.class_rooms.create(year: year)
              end
              @user.value!(class_room, value) unless @user.value?(class_room)
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