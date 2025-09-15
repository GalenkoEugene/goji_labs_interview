require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Students API', type: :request do
  path '/api/v1/students' do
    get('list students') do
      tags 'Students'
      produces 'application/json'

      response(200, 'successful') do
        let!(:students) { create_list(:student, 3) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(3)
        end
      end
    end
  end


  path '/api/v1/students/{student_id}/schedule' do
    get('Retrieves the schedule for a student') do
      tags 'Student Schedule'
      produces 'application/json'
      parameter name: 'student_id', in: :path, type: :string, description: 'ID of the student'

      response(200, 'successful') do
        let(:student) { create(:student) }
        let(:section) { create(:section) }
        let(:student_id) { student.id }

        before { student.sections << section }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(1)
          expect(data.first['id']).to eq(section.id)
        end
      end
    end
  end

  path '/api/v1/students/{student_id}/sections/{section_id}' do
    post('Adds a section to a student schedule') do
      tags 'Student Schedule'
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'student_id', in: :path, type: :string, description: 'ID of the student'
      parameter name: 'section_id', in: :path, type: :string, description: 'ID of the section to add'

      response(201, 'section added') do
        let(:student) { create(:student) }
        let(:section) { create(:section, days: [ "Tue", "Thu" ], start_time: '10:00:00', end_time: '11:20:00') }
        let(:student_id) { student.id }
        let(:section_id) { section.id }

        run_test! do
          expect(student.sections.count).to eq(1)
        end
      end

      response(422, 'schedule conflict') do
        let(:student) { create(:student) }
        let(:existing_section) { create(:section, days: [ "Mon", "Wed", "Fri" ], start_time: '08:00:00', end_time: '08:50:00') }
        let(:conflicting_section) { create(:section, days: [ "Mon", "Wed", "Fri" ], start_time: '08:30:00', end_time: '09:20:00') }
        let(:student_id) { student.id }
        let(:section_id) { conflicting_section.id }

        before { student.sections << existing_section }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to include(/Schedule conflict detected/)
          expect(student.sections.count).to eq(1) # Should not have been added
        end
      end
    end

    delete('Removes a section from a student schedule') do
      # ... you can add tests for the delete action here in a similar fashion
    end
  end
end
