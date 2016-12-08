require 'rails_helper'

RSpec.describe PlacesController, type: :controller do  
    
  describe "places#index action" do
    it "should show the cafes" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "places#new action" do
    it "should not show the new place form if the user is not logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    
    it "shoud show the new place form if the user is logged in" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :new
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "places#create action" do
    it "should not create new place if the user is not logged in" do
      params = {
        place: {
          name: 'Cafe Lingo',
          description: 'Where the cool kids are.',
          address: '68 Jay Street, Suite 720, Brooklyn 11201'
        }
      }
      post :create, params
      expect(response).to redirect_to new_user_session_path
    end
  end
     
  describe "places#check_unique action" do
    login_user
    it "has a 200 status code when current user has never created this place before" do
      
      params = {
        place: {
          name: 'Cafe Lingo',
          description: 'Where the cool kids are.',
          address: '68 Jay Street, Suite 720, Brooklyn 11201'
        }
      }
      post :check_unique, params
      expect(response).to have_http_status(:ok)
    end
    
    it "has a 409 status code when current user has created this place before" do
      place = FactoryGirl.create(:place, user_id: @current_user)
      params = {
        place: {
          name: 'Cafe Lingo',
          description: 'Where the cool kids are.',
          address: '68 Jay Street, Suite 720, Brooklyn 11201'
        }
      }
      post :check_unique, params
      expect(response).to have_http_status(:conflict)
    end
    
    it "has a 200 status code for a different user" do
      user = FactoryGirl.create(:user)
      sign_in user
      params = {
        place: {
          name: 'Cafe Lingo',
          description: 'Where the cool kids are.',
          address: '68 Jay Street, Suite 720, Brooklyn 11201'
        }
      }
      post :check_unique, params
      expect(response).to have_http_status(:ok)
    end
      
  end
end



