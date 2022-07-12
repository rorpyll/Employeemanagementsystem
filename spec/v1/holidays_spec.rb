# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::HolidaysController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let!(:holiday) { FactoryBot.create(:holiday) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all holidays ' do
      get :index, params: { format: :json }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(holiday.id)
    end
  end
end
