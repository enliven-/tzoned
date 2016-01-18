require 'rails_helper'

RSpec.describe TimezonesController, type: :controller do
  
  describe 'GET #index' do
    before(:each) do
      4.times { FactoryGirl.create :timezone }
      get :index
    end

    it 'returns records from the database as json array' do
      timezones_response = json_response[:timezones]
      expect(timezones_response).to be_a Array
    end

    # it 'returns the user object into each timezone' do
    #   timezones_response = json_response[:timezones]
    #   timezones_response.each do |timezone_response|
    #     expect(timezone_response[:user]).to be_present
    #   end
    # end

    it { should respond_with 200 }
  end


  describe 'GET #show' do
    before(:each) do
      @timezone = FactoryGirl.create :timezone
      get :show, id: @timezone.id
    end

    it 'returns the information about timezone as a hash' do
      timezone_response = json_response[:timezone]
      expect(timezone_response[:name]).to eql @timezone.name
    end

    # it 'has the user as a embeded object' do
    #   timezone_response = json_response[:timezone]
    #   expect(timezone_response[:user][:email]).to eql @timezone.user.email
    # end

    it { should respond_with 200 }
  end



  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        user = FactoryGirl.create :user
        @timezone_attributes = FactoryGirl.attributes_for :timezone
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, timezone: @timezone_attributes }
      end

      it 'renders the json representation for the timezone record just created' do
        timezone_response = json_response[:timezone]
        expect(timezone_response[:name]).to eql @timezone_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_timezone_attributes = { gmt_difference: 'something', city_id: 1 } # name not present
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, timezone: @invalid_timezone_attributes }
      end

      it 'renders an errors json' do
        timezone_response = json_response
        expect(timezone_response).to have_key(:errors)
      end

      it 'renders the json errors on whye the user could not be created' do
        timezone_response = json_response
        expect(timezone_response[:errors][:gmt_difference]).to include 'is not a number'
      end

      it { should respond_with 422 }
    end
  end



  describe 'PUT/PATCH #update' do
    before(:each) do
      @user = FactoryGirl.create :user
      @timezone = FactoryGirl.create :timezone, user: @user
      api_authorization_header @user.auth_token
    end

    context 'when is successfully updated' do
      before(:each) do
        patch :update, { user_id: @user.id, id: @timezone.id,
              timezone: { name: 'CT' } }
      end

      it 'renders the json representation for the updated timezone' do
        timezone_response = json_response[:timezone]
        expect(timezone_response[:name]).to eql 'CT'
      end

      it { should respond_with 200 }
    end

    context 'when is not updated' do
      before(:each) do
        patch :update, { user_id: @user.id, id: @timezone.id,
              timezone: { gmt_difference: 'two hundred' } }
      end

      it 'renders an errors json' do
        timezone_response = json_response
        expect(timezone_response).to have_key(:errors)
      end

      it 'renders the json errors on whye the user could not be created' do
        timezone_response = json_response
        expect(timezone_response[:errors][:gmt_difference]).to include 'is not a number'
      end

      it { should respond_with 422 }
    end
  end



  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryGirl.create :user
      @timezone = FactoryGirl.create :timezone, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @timezone.id }
    end

    it { should respond_with 204 }
  end
end
