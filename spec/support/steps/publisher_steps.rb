module PublisherSteps
  def publisher_check_list(*order)
    items = all('section.search-result-item')
    expect(items.count).to eq(order.size)
    items.each_with_index do |item, index|
      expect(item).to have_content(publishers[order[index] - 1][:user].email)
    end
  end
end