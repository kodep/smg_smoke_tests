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
    sleep 10
    page.all(:css, 'div.report button.button-inverse').first.click
    sleep 10
    page.all(:css, "form[name='report'] span.select-button").first.click
    sleep 10
    page.all(:css, "span.ui-select-choices-row-inner").first.click
    sleep 10
    page.all(:css, "form[name='report'] button.button-primary").last.click
    sleep 10
    screenshot_and_open_image
    exec("./check_sidekiq_worker.sh")
    sleep 2
    p ENV['WORKER_STARTED']
    # expect(page.has_content?(user.name)).to be_truthy
  end

end
