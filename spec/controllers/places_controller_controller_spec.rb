require 'rails_helper'

RSpec.describe PlacesController, type: :controller do     
    describe "POST check_unique" do
        login_user
        
        it "has a 200 status code" do
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
        
        it "has a conflict status code" do
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
    end
end



