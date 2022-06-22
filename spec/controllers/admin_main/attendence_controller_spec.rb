# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminMain::AttendencesController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }
  let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id, checkin_time: Time.now) }

  before do
    sign_in(employee)
  end

  describe 'index' do
    it 'Get Attendence' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    it 'Admin can see perticular employee attendence' do
      get :show, params: { id: attendence.id }
      expect(assigns(:attendences)).to eq([attendence])
    end

    it 'return root path when attendence not exit' do
      get :show, params: { id: '' }
      assert_response(302)
    end
  end

  describe '#edit' do
    it 'response successfully when attendence data is exist' do
      get :edit, params: { id: attendence.id }
      expect(response.status).to eq(200)
    end
    it 'return nil when attendence not exist' do
      get :edit, params: { id: '' }
      expect(assigns(:attendence)).to eq(nil)
    end
  end

  describe '#update attendence ' do
    it 'checkout by employee' do
      patch :update, params: { id: attendence.id }
      expect(assigns(:attendence)).to eq(attendence)
    end

    it 'return nil when attendence not exist' do
      patch :update, params: { attendence: { name: 'Xyz' }, id: '' }
      expect(assigns(:attendence)).to eq(nil)
    end
  end
end
