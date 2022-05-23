# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendencesController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }
  let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id) }
  before do
    sign_in(employee)
  end

  describe 'index' do
    it 'Get Attendence' do
      get :index
      expect(response.status).to eq(200)
    end

    context 'Show Attendence' do
      it 'renders a successful response when Attendence exist' do
        get :show, params: { id: attendence.id }
        expect(assigns(:attendence)).to eq(attendence)
      end

      it 'redirect to root path if Attendence is not exist' do
        get :show, params: { id: '' }
        assert_response(302)
      end
    end
  end

  describe 'create' do
    it 'checkin' do
      post :create, params: { employee_id: employee.id }
      expect(response.status).to eq(302)
    end
  end

  describe 'update attendence' do
    let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id, checkin_time: Time.now) }
    it 'checkout by employee' do
      patch :update_attendence
      expect(response.status).to eq(302)
    end
  end
end
