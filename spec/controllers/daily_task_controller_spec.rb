# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyTasksController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) do
    FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id,
                                 joining_date: '2022-5-14')
  end
  let!(:employee_one) do
    FactoryBot.create(:employee, role_id: roles(:role_two).id, designation_id: designation.id,
                                 joining_date: '2022-5-14')
  end
  let!(:daily_task) { FactoryBot.create(:daily_task, employee_id: employee_one.id) }
  let!(:daily_task_one) { FactoryBot.create(:daily_task, employee_id: employee.id) }

  before do
    sign_in(employee)
  end

  describe '#Hr' do
    before do
      sign_in(employee)
    end
    it 'Show Employee daily task when role is hr' do
      get :index
      expect(assigns(:daily_tasks).count).to eq(2)
    end

    it 'Hr can see all employee daily task' do
      get :show, params: { id: daily_task.id }
      expect(assigns(:daily_task)).to eq(daily_task)
    end

    it 'render 404 when daily task not exit' do
      get :show, params: { id: '' }
      expect(response.status).to eq(404)
    end
  end

  describe '#Employee' do
    before do
      sign_in(employee_one)
    end
    it 'Show only current Employee daily task when role is employee' do
      get :index
      expect(assigns(:daily_tasks).count).to eq(1)
    end

    it 'Employee can see our daily task' do
      get :show, params: { id: daily_task.id }
      expect(response.status).to eq(200)
    end

    it 'render 404 when daily task not exit' do
      get :show, params: { id: '' }
      expect(response.status).to eq(404)
    end
  end

  describe '#New' do
    it 'new' do
      get :new
      expect(response.status).to eq(302)
    end

    it 'created successfully' do
      get :create, params: { daily_task: { employee_id: employee.id, description: 'xyz' } }
      expect(response.status).to eq(302)
    end

    it 'render new page if validation faild ' do
      post :create, params: { daily_task: { employee_id: employee.id, description: nil } }
      expect(response.status).to eq(200)
    end
  end

  describe '#Edit' do
    it 'edit' do
      get :edit, params: { id: daily_task.id }
      expect(response.status).to eq(200)
    end

    it 'render 404 when daily task not exit' do
      get :edit, params: { id: '' }
      expect(response.status).to eq(404)
    end
  end

  describe '#update' do
    it 'update' do
      put :update, params: { daily_task: { description: 'i am working on EMS' }, id: daily_task_one.id }
      expect(response.status).to eq(302)
    end

    it 'render 404 when daily task not exit' do
      put :update, params: { daily_task: { description: 'i am working on EMS' }, id: '' }
      expect(response.status).to eq(404)
    end
  end
end
