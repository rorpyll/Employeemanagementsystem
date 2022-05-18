# frozen_string_literal: true

require 'rails_helper'

describe V1::EmployeesController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }

  # before do
  #   sign_in(employee)
  # end

  describe 'GET# employees#show' do
    before do
      get :show, params: { id: employee.id }
    end

    it 'show the employee details' do
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    context '#with valid parameters' do
      it 'render to update' do
        patch :update, params: { employee: { password: 'password' }, id: employee.id }
        assert_response(200)
      end
    end

    context 'with valid parameters' do
      it 'render 404 when employee is not exist' do
        patch :update, params: { employee: { password: 'password' }, id: '' }
        assert_response(404)
      end
    end
  end
end
