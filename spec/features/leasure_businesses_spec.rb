require 'spec_helper'

context 'Leasure Businesses', type: :feature, js: true do

  it 'login as leasure business' do
    user = FactoryGirl.create(:af_user, :publisher)
    publisher = FactoryGirl.create(:af_publisher)
    visit '/'
    page.all(:css, 'div.auth-links a.login').first.click
    page.find(:css, '#e-mail').set(user.email)
    page.find(:css, '#password').set('password')
    page.find(:css, 'div.modal-footer button.btn.btn-red').click
    sleep 1
    expect(page.has_content?(user.name)).to be_truthy
  end
end
