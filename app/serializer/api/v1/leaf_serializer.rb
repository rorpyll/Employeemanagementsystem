# frozen_string_literal: true

module Api
  module V1
    class LeafSerializer < ActiveModel::Serializer
      attributes :id, :leave_type, :from_date, :till_date, :total_days, :reason, :leave_status
    end
  end
end
