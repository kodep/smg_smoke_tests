module UserSpecHelper
  def user
    @user ||= create(:af_user, :admin)
  end
end