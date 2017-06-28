module UserSteps
  def authorize(page)
    visit '/'
    page.all(:css, 'div.auth-links a.login').first.click
    page.find(:css, '#e-mail').set(user.email)
    page.find(:css, '#password').set('password')
    page.find(:css, 'div.modal-footer button.btn.btn-red').click
    sleep 1
  end
end
