# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::HolidaysController, type: :controller do
  let!(:holiday) { FactoryBot.create(:holiday) }

  describe 'GET# holidays#index' do
    before do
      get :index
    end

    it 'index the holidays list' do
      expect(response.status).to eq(200)
    end
  end
end
