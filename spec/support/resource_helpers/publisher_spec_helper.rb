module PublisherSpecHelper
  def publishers
    cache.fetch '@publishers' do
      publishers = []
      6.times { |i| publishers << create(:af_publisher) }
      publishers
    end
  end
end
