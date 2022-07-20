# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_employee!
      skip_before_action :verify_authenticity_token

      def index
        ticket_data = current_employee.tickets
        render json: {
          data: serializer_data(ticket_data, ticket_serializer),
          message: ['show tickets '], status: 200, type: 'Success'
        }
      end

      def create
        ticket_data = Ticket.new(ticket_params)
        if ticket_data.save
          render json: {
            data: serializer_data(ticket_data, ticket_serializer),
            message: ['Successfully ticket create '], status: 200, type: 'Success'
          }
        else
          render json: ticket_data, status: 302, type: 'Found'
        end
      end

      private

      def ticket_params
        params.require(:ticket).permit(:status, :description, :ticket_type, :employee_id, :reason)
      end

      def ticket_serializer
        Api::V1::TicketSerializer
      end
    end
  end
end
