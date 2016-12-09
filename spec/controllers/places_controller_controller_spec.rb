require 'rails_helper'

RSpec.describe PlacesController, type: :controller do  
  
  params = {
    place: {
      name: 'Cafe Lingo',
      description: 'Where the cool kids are.',
      address: '68 Jay Street, Suite 720, Brooklyn 11201'
    }
  }
  
  describe "places#index action" do
    it "should show all the cafes" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "places#new action" do
    it "should redirect user to login view if the user is not logged in" do
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
    it "should redirect user to login view if the user is not logged in" do
      post :create, params
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should redirect user to index path and create a new place in db" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, params
      expect(response).to redirect_to root_path
      
      # also check the creation of place in DB
      place = Place.last
      expect(place.name).to eq('Cafe Lingo')
      expect(place.user).to eq(user)
    end
    
    it "should show validation errors when new place form is not filled out properly" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      params = {
        place: {
          name: '',
          description: '',
          address: ''
        }
      }
      
      place_cnt = Place.count
      post :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(place_cnt).to eq Place.count  # count should not change
    end
  end
  
  describe "places#show action" do
    it "should show the cafe page if it is found" do
      user = FactoryGirl.create(:user)
      sign_in user
      cafe = FactoryGirl.create(:place, user_id: user.id)
      get :show, id: cafe.id
      expect(response).to have_http_status(:ok)
    end
    
    it "should return a 404 error if the place is not found" do
      get :show, id: 'celia'
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe "places#edit action" do
    it "should redirect user to login view if the user is not logged in" do
      get :edit, id: '12'
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should show the edit form if the place is found and created by the current user" do
      user = FactoryGirl.create(:user)
      sign_in user

      cafe = FactoryGirl.create(:place, user_id: user.id)
  
      get :edit, id: cafe.id
      expect(response).to have_http_status(:ok)
    end
    
    it "should return a 403 error if the place is created by another user" do
      user1 = FactoryGirl.create(:user)
      sign_in user1
      cafe = FactoryGirl.create(:place, user_id: user1.id)
      
      user2 = FactoryGirl.create(:user)
      sign_in user2
      
      get :edit, id: cafe.id
      expect(response).to have_http_status(:forbidden)
    end
    
    it "should return a 404 error if the place is not found" do
      user1 = FactoryGirl.create(:user)
      sign_in user1
      get :edit, id: 'celia1'
      expect(response).to have_http_status(:not_found)
    end
  end
     
  describe "places#check_unique action" do
    login_user
    it "should return a 200 status code when current user has never created this place before" do
      
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
    
    it "should return a 409 error when current user has created this place before" do
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
    
    it "should return a 200 status code for a different user" do
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



