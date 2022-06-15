# frozen_string_literal: true

module AdminMain
  class HolidaysController < ApplicationController
    def index
      @holidays = Holiday.all
    end

    def new
      @holiday = Holiday.new
    end

    def create
      @holiday = Holiday.new(holiday_params)
      if @holiday.save
        redirect_to admin_main_holidays_path
      else
        render :new, status: 302
      end
    end

    def edit
      @holiday = Holiday.find(params[:id])
    end

    def update
      @holiday = Holiday.find(params[:id])

      if @holiday.update(holiday_params)
        redirect_to admin_main_holidays_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @holiday = Holiday.find(params[:id])
      if @holiday.destroy
        redirect_to admin_main_holidays_path
      else
        render :index
      end
    end

    private

    def holiday_params
      params.require(:holiday).permit(:holiday_date, :holiday_name, :holiday_type)
    end
  end
end
