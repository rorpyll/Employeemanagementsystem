require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/performances", type: :request do
  
  # Performance. As you add validations to Performance, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Performance.create! valid_attributes
      get performances_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      performance = Performance.create! valid_attributes
      get performance_url(performance)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_performance_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      performance = Performance.create! valid_attributes
      get edit_performance_url(performance)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Performance" do
        expect {
          post performances_url, params: { performance: valid_attributes }
        }.to change(Performance, :count).by(1)
      end

      it "redirects to the created performance" do
        post performances_url, params: { performance: valid_attributes }
        expect(response).to redirect_to(performance_url(Performance.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Performance" do
        expect {
          post performances_url, params: { performance: invalid_attributes }
        }.to change(Performance, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post performances_url, params: { performance: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested performance" do
        performance = Performance.create! valid_attributes
        patch performance_url(performance), params: { performance: new_attributes }
        performance.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the performance" do
        performance = Performance.create! valid_attributes
        patch performance_url(performance), params: { performance: new_attributes }
        performance.reload
        expect(response).to redirect_to(performance_url(performance))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        performance = Performance.create! valid_attributes
        patch performance_url(performance), params: { performance: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested performance" do
      performance = Performance.create! valid_attributes
      expect {
        delete performance_url(performance)
      }.to change(Performance, :count).by(-1)
    end

    it "redirects to the performances list" do
      performance = Performance.create! valid_attributes
      delete performance_url(performance)
      expect(response).to redirect_to(performances_url)
    end
  end
end
