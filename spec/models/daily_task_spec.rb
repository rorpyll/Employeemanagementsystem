# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyTask, type: :model do
  fixtures :all

  let!(:designation) { FactoryBot.create(:designation) }
  let!(:employee) do
    FactoryBot.create(:employee, role_id: roles(:role_one).id, designation_id: designation.id,
                                 joining_date: '2022-5-14')
  end
  let!(:daily_task) { FactoryBot.create(:daily_task, employee_id: employee.id, description: 'i am working on EMs') }

  describe '#validation' do
    it 'return true when description is present' do
      expect(daily_task.save).to eq(true)
    end

    it 'return false when description is nil' do
      daily_task.description = nil
      expect(daily_task.save).to eq(false)
    end
  end
end
