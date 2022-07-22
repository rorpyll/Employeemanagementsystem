# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AttendencesController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all Attendences ' do
      get :index, params: { format: :json }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(attendence.id)
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    before do
      get :show, params: { id: attendence.id }
    end

    it 'show the Attendences details' do
      response_body = JSON.generate(response.body)
      expect(response.status).to eq(302)
    end
  end

  describe '#create' do
    context 'create a Attendences' do
      let(:valid_attendence) { attributes_for(:attendence, employee_id: employee.id) }
      it 'successful response when Attendences create' do
        post :create, params: { attendence: valid_attendence }
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(['successfully checkin '])
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#update' do
    let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id, checkin_time: Time.now) }
    it 'checkout by employee' do
      patch :update, params: { id: attendence.id }
      response_body = JSON.parse(response.body)
      expect(response_body['message']).to eq(['successfully updated '])
      expect(response.status).to eq(200)
    end
  end
end
