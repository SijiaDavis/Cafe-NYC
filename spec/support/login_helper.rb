module LoginHelper
  def login_user
    user = FactoryGirl.create(:user)
    sign_in user
    @current_user = user.id
    return user
  end
end