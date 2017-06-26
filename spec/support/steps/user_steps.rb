module UserSteps
  def authorize
    visit login_path
    fill_in 'exampleInputEmail1', with: user.email
    fill_in 'pswd', with: user.password
    find('a[ng-click="login()"]').click
    wait_for(lambda { current_pathname == login_path }) do
      current_path_should_be(adverts_path)
    end
  end
end