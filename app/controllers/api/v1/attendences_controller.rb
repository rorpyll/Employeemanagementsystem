# frozen_string_literal: true

module Api
  module V1
    class AttendencesController < ApplicationController
      before_action :authenticate_employee!
      before_action :set_attendance, only: %i[show]
      skip_before_action :verify_authenticity_token

      def index
        attendence_data = current_employee.attendences.order(created_at: :desc)
        render json: {
          data: serializer_data(attendence_data, attendence_serializer),
          message: ['daily attendence list '], status: 200, type: 'Success'
        }
      end

      def show
        attendence_data = current_employee.attendences #Attendence.where(employee_id: attendence.employee_id)
        render json: {
          data: serializer_data(attendence_data, attendence_serializer),
          message: ['show daily attendence  '], status: 302, type: 'Success'
        }
      end

      def create
        attendence_data = Attendence.where(checkin_time: Time.zone.now - 2.minutes..Time.zone.now,
                                           employee_id: current_employee.id).last
        if attendence_data.nil?
          attendence_data = Attendence.create(employee_id: current_employee.id, checkin_time: Time.zone.now,
                                              status: 'Present', checkin_ip_address: request.remote_ip)
        else
          attendence_data.update_column('checkout_time', nil)
        end
        render json: {
          data: serializer_data(attendence_data, attendence_serializer),
          message: ['successfully checkin '], status: 200, type: 'Success'
        }
      end

      def update
        attendence_data = current_employee.todays_last_attendence
        attendence_data.update(checkout_time: Time.zone.now, checkout_ip_address: request.remote_ip)
        render json: {
          data: serializer_data(attendence_data, attendence_serializer),
          message: ['successfully updated '], status: 200, type: 'Success'
        }
      end

      def set_attendance
        attendence = current_employee.attendences.find_by_id params[:id]
      end

      private

      def attendence_serializer
        Api::V1::AttendenceSerializer
      end
    end
  end
end
