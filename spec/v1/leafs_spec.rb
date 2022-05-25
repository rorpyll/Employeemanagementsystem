# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::LeafsController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let(:leaf) { FactoryBot.create(:leaf, employee_id: employee.id, from_date: Time.now, till_date: Time.now) }
  let(:leaf_one) do
    FactoryBot.create(:leaf, employee_id: employee.id, from_date: Time.now + 1.day, till_date: Time.now + 1.day)
  end

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
    context 'apply for leave' do
      it 'renders a successful response when leave applied' do
        post :create, params: { leaf: { employee_id: employee.id, from_date: '2022-05-26', till_date: '2022-05-27' } }
        expect(response.status).to eq(200)
      end

      it 'renders a failed response when leave not created' do
        post :create, params: { leaf: { employee_id: employee.id, from_date: '2022-05-21', till_date: '2022-05-22' } }
        expect(response.status).to eq(404)
      end
    end
  end

  describe '#update' do
    context 'update leave status' do
      it 'renders a successful response when leave status update' do
        patch :update,
              params: { leaf: { leave_status: 'cancel' }, id: leaf_one.id }
        assert_response(200)
      end

      it 'renders a failed response when leave not status update' do
        patch :update,
              params: { leaf: { leave_status: 'cancel' }, id: leaf.id }
        assert_response(304)
      end
    end
  end
end
