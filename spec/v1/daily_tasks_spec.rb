# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::DailyTasksController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let(:daily_task) { FactoryBot.create(:daily_task, employee_id: employee.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all DailyTasks ' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET# DailyTasks#show' do
    before do
      get :show, params: { id: daily_task.id }
    end

    it 'show the DailyTasks details' do
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'create a DailyTask' do
      post :create, params: { daily_task: { discription: 'today tasks' } }
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    it 'render to update' do
      patch :update,
            params: { daily_task: { discription: 'my task' }, id: daily_task.id }
      assert_response(200)
    end
  end
end
