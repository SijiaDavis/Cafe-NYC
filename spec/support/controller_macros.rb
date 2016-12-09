module ControllerMacros
  def login_user_g
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
      @current = user.id
    end
  end
end