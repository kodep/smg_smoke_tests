require 'spec_helper'

context 'Leasure Businesses', type: :feature, js: true do

  let(:user) { FactoryGirl.create(:st_user, :publisher) }
  let(:publisher) { FactoryGirl.create(:st_publisher) }

  before(:each) do
    authorize(page)
  end

  it 'checks login as leasure business' do
    expect(page.has_content?(user.name)).to be_truthy
  end

  it 'checks addition the option for LB to add other email addresses to send report to other emails as well' do
    visit '#/transactions'
    screenshot_and_open_image
    # expect(page.has_content?(user.name)).to be_truthy
  end

end
