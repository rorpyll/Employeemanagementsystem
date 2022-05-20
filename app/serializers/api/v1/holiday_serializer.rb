# frozen_string_literal: true

module Api
  module V1
    class HolidaySerializer < ActiveModel::Serializer
      attributes :holiday_date, :holiday_name
    end
  end
end
