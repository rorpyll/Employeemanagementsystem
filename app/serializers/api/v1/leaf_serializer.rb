# frozen_string_literal: true

module Api
  module V1
    class LeafSerializer < ActiveModel::Serializer
      attributes :id, :leave_type, :from_date, :till_date, :leave_starts, :leave_end, :total_days, :resion, :leave_status,
                 :employee_id
    end
  end
end
