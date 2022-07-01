# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminMain::DailyTasksController, type: :controller do
  fixtures :roles

  let!(:designation) { FactoryBot.create(:designation) }

  let!(:employee) do
    FactoryBot.create(:employee, role_id: roles(:role_two).id, designation_id: designation.id)
  end
  let!(:daily_task) { FactoryBot.create(:daily_task, employee_id: employee.id) }
  let!(:daily_task_one) { FactoryBot.create(:daily_task, employee_id: employee.id) }
  let!(:daily_task_two) { FactoryBot.create(:daily_task, employee_id: employee_one.id) }
  let!(:employee_one) { FactoryBot.create(:employee, role_id: roles(:role_three).id, designation_id: designation.id) }
  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'Show Employee daily task when role is admin' do
      get :index
      expect(assigns(:daily_tasks).count).to eq(3)
    end

    it 'search daily task' do
      get :index, params: { daily_tasks: employee_one.name }
      expect(assigns(:daily_task)).to eq([daily_task, daily_task_one, daily_task_two])
    end
  end

  describe '#show' do
    it 'Admin can see all employee daily task' do
      get :show, params: { id: daily_task.id }
      expect(response.status).to eq(200)
    end

    it 'render 404 when daily task not exit' do
      get :show, params: { id: '' }
      expect(response.status).to eq(302)
    end
  end
end
