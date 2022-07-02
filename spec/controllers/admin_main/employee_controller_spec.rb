# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminMain::EmployeesController, type: :controller do
  fixtures :roles

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'Get Employees' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    it 'Show Employee' do
      get :show, params: { id: employee.id }
      expect(assigns(:employee)).to eq(employee)
    end

    it 'return nil when employee not exist' do
      get :show, params: { id: '' }
      expect(assigns(:employee)).to eq(nil)
    end
  end

  describe '#new' do
    it 'create new employee' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'create new employee' do
      post :create, params: { employee: { name: 'xyz' } }
      expect(response.status).to eq(200)
    end
  end

  describe '#destroy' do
    it 'delete employee data' do
      delete :destroy, params: { id: employee.id }
      expect(Employee.all.count).to eq(0)
    end
  end
end
