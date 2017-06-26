require 'spec_helper'

context 'Initial', type: :feature, js: true do

  it 'is initial spec' do
    user = FactoryGirl.create(:af_user, :publisher)
    publisher = FactoryGirl.create(:af_publisher)
    visit '/'
    page.all(:css, 'div.auth-links a.login').first.click
    page.find(:css, '#e-mail').set(user.email)
    page.find(:css, '#password').set('password')
    page.find(:css, 'div.modal-footer button.btn.btn-red').click
    sleep 1
    screenshot_and_open_image
  end
end
