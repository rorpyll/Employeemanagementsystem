# frozen_string_literal: true

module Api
  module V1
    class DailyTaskSerializer < ActiveModel::Serializer
      attributes :id,:description,:employee_id
    end
  end
end
