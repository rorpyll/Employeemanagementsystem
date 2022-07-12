# frozen_string_literal: true

module Api
  module V1
    class AttendenceSerializer < ActiveModel::Serializer
      attributes :id, :checkin_time, :checkout_time, :status, :hour
    end
  end
end
