# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TicketsController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:designation) { FactoryBot.create(:designation) }
  let(:employee) { FactoryBot.create(:employee, designation_id: designation.id, role_id: role.id) }
  let!(:ticket) { FactoryBot.create(:ticket, employee_id: employee.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'show all ticket ' do
      get :index, params: { format: :json }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(ticket.id)
    end
  end

  describe '#create' do
    context 'create ticket' do
      let(:valid_ticket) { attributes_for(:ticket, employee_id: employee.id) }
      let(:invalid_ticket) do
        attributes_for(:ticket, employee_id: employee.id, description: nil, reason: nil, ticket_type: nil, status: nil)
      end
      it 'renders a successful response when ticket created' do
        post :create, params: { ticket: valid_ticket }
        expect(Ticket.count).to eq(2)
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(['Successfully ticket create '])
        expect(response.status).to eq(200)
      end

      it 'renders a response when ticket not created' do
        post :create, params: { ticket: invalid_ticket }
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(302)
      end
    end
  end
end
