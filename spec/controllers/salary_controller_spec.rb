# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalariesController, type: :controller do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:monthly_salaray) { FactoryBot.create(:monthly_salary, month: '6', monthly_working_days: 20) }
  let!(:employee) do
    FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id, salary: 10_000)
  end
  let!(:employee_one) do
    FactoryBot.create(:employee, role_id: roles(:role_two).id, designation_id: designation.id, salary: 10_000)
  end
  let!(:salary) { FactoryBot.create(:salary, employee_id: employee.id, monthly_salary_id: monthly_salaray.id) }
  let!(:salary_one) { FactoryBot.create(:salary, employee_id: employee_one.id, monthly_salary_id: monthly_salaray.id) }

  before do
    sign_in(employee)
  end

  describe '#index' do
    it 'Hr can see all employee salaries' do
      get :index
      expect(assigns(:salaries)).to eq([salary, salary_one])
    end
  end

  describe '#index' do
    before do
      sign_in(employee_one)
    end

    it 'Employee can not see other employee salaries' do
      get :index
      expect(assigns(:salaries)).to eq([salary_one])
    end
  end

  describe '#show' do
    it 'Employee can see download pdf' do
      get :show, params: { id: salary.id }
      expect(assigns(:salary)).to render_template(:show)
    end

    it 'return root path when employee salary not found' do
      get :show, params: { id: '' }
      expect(response).to redirect_to(redirect_to(root_path))
    end
  end
end
