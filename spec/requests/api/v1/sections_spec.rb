require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Sections API', type: :request do
  path '/api/v1/sections' do
    get('list sections') do
      tags 'Sections'
      produces 'application/json'

      response(200, 'successful') do
        let!(:sections) { create_list(:section, 2) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(2)
        end
      end
    end
  end

  path '/api/v1/sections/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show section') do
      tags 'Sections'
      produces 'application/json'

      response(200, 'successful') do
        let(:section) { create(:section) }
        let(:id) { section.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(section.id)
        end
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
