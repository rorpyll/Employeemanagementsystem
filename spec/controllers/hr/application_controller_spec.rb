# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hr::ApplicationController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:hr) { FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id) }
  let!(:employee) { FactoryBot.create(:employee, role_id: roles(:role_two).id, designation_id: designation.id) }
  let!(:attendence) { FactoryBot.create(:attendence, employee_id: employee.id) }

  describe '#authorize' do
    controller do
      before_action :authorize_hr

      def index
        head :ok
      end
    end

    context 'current employee role is employee' do
      before do
        sign_in(employee)
      end
      it 'redirects to root path when employee role is employee' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    context 'current employee role is hr' do
      before do
        sign_in(hr)
      end
      it 'response successfully when employee role is hr' do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
end
