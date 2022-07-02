# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hr::MonthlySalariesController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }
  let!(:monthly_salaray_one) { FactoryBot.create(:monthly_salary, month: '6', monthly_working_days: 20) }
  let!(:monthly_salaray_two) { FactoryBot.create(:monthly_salary, month: '7', monthly_working_days: 20) }
  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'Get all monthly salaries' do
      get :index
      expect(assigns(:monthly_salaries)).to eq([monthly_salaray_one, monthly_salaray_two])
    end
  end

  describe '#new' do
    it 'create new monthly salary' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'response successfully when monthly salary created' do
      post :create, params: { monthly_salary: { month: '5', monthly_working_days: 23 } }
      expect(response.status).to eq(302)
    end
  end

  describe '#update' do
    it 'response successfully when monthly salary updated' do
      patch :update, params: { id: monthly_salaray_one.id, company_level: false }
      expect(assigns(:monthly_salary).company_level).to eq(false)
    end
  end
end
