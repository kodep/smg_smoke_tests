RSpec::Matchers.define :has_publishers_in_order do |*expected_order|
  match do |element|
    items = element.all('section.search-result-item')
    unless items.count == expected_order.size
      @count_error = {expected: expected_order.size, given: items.count}
      return false
    end
    @expected_email = expected_order.map {|num| publishers[num - 1][:user].email }
    @given_emails = items.inject([]) do |sum, item|
      sum + [item.all('*', text: /\h+@.+\.com/).try(:last).try(:text)]
    end
    @given_emails == @expected_email
  end

  failure_message do |actual|
    if @count_error
      expected = "expected publisher items in size of: #{@count_error[:expected]}"
      given = @count_error[:given]
    else
      expected = "expected publishers in order: #{@expected_email}"
      given = @given_emails
    end
    "#{expected}\n#{"but given: #{given}".rjust(expected.size)}"
  end

  description do
    'checks publishers and their order'
  end
end