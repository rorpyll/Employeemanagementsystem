# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::LeafsController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let(:leaf) { FactoryBot.create(:leaf, employee_id: employee.id, from_date: Time.now, till_date: Time.now) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all leave ' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'apply for leave' do
      post :create, params: { leaf: { employee_id: employee.id, from_date: Time.now, till_date: Time.now } }
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    it 'render to update' do
      patch :update,
            params: { leaf: { leave_status: 'cancel' }, id: leaf.id }
      assert_response(200)
    end
  end
end
