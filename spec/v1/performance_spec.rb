# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::PerformancesController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let!(:performance) { FactoryBot.create(:performance, employee_id: employee.id) }

  describe '#index' do
    it 'show all performance ' do
      get :index, params: { format: :json }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(performance.id)
    end
  end
end
