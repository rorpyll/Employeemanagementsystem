# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::DailyTasksController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let!(:daily_task) { FactoryBot.create(:daily_task, employee_id: employee.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all DailyTasks ' do
      get :index, params: { format: :json }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(daily_task.id)
    end
  end

  describe '#show' do
    before do
      get :show, params: { id: daily_task.id }
    end

    it 'show the DailyTasks details' do
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'render 404 code if daily_task is not exist' do
      get :show, params: { id: '' }
      response_body = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    context 'create daily_task' do
      let(:valid_daily_task) do
        attributes_for(:daily_task, employee_id: employee.id, description: 'i am working on EMS')
      end

      let(:invalid_daily_task) do
        attributes_for(:daily_task, employee_id: employee.id, description: nil)
      end
      it 'successful response when DailyTask create' do
        post :create, params: { daily_task: valid_daily_task }
        expect(DailyTask.count).to eq(2)
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(200)
      end

      it 'renders a response when DailyTask not created' do
        post :create, params: { daily_task: invalid_daily_task }
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#update' do
    context 'update daily_task' do
      it 'renders a successful response when DailyTask update' do
        put :update, params: { daily_task: { description: 'i am working on EMS' }, id: daily_task.id }
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:data][:description]).to eq('i am working on EMS')
        expect(response.status).to eq(200)
      end

      it 'render 404 when daily task not exit' do
        put :update, params: { daily_task: { description: 'i am working on EMS' }, id: '' }
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:message]).to eq('Not Found')
        expect(response.status).to eq(404)
      end
    end
  end
end
