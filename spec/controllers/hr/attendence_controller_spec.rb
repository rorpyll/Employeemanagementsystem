# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hr::AttendencesController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }
  let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id, checkin_time: Time.now) }

  before do
    sign_in(employee)
  end

  describe '#show attendences' do
    it 'Hr can see all employee attendences' do
      get :show_attendence, params: { id: employee.id }
      expect(assigns(:attendences)).to eq([attendence])
    end
  end

  describe '#show' do
    it 'Hr can see perticular employee attendence' do
      get :show, params: { id: attendence.id }
      expect(assigns(:attendences)).to eq([attendence])
    end

    it 'return root path when attendence not exit' do
      get :show, params: { id: '' }
      expect(response.status).to eq(302)
    end
  end

  describe '#edit' do
    it 'response successfully when attendence exit' do
      get :edit, params: { id: attendence.id }
      expect(assigns(:attendence)).to eq(attendence)
    end

    it 'return root path when attendence not exit' do
      get :edit, params: { id: '' }
      expect(response.status).to eq(302)
    end
  end

  describe '#update' do
    it 'response successfully when attendence exit' do
      patch :update, params: { id: attendence.id }
      expect(assigns(:attendence)).to eq(attendence)
    end

    it 'return root path when attendence not exit' do
      patch :update, params: { id: '' }
      expect(response.status).to eq(302)
    end
  end

  describe '#search' do
    it 'search' do
      get :search, params: { start_date: Time.now.to_date, end_date: Time.now.to_date + 2.days, id: employee.id },
                   xhr: true
      expect(assigns(:attendences)).to eq([attendence])
    end
  end
end
