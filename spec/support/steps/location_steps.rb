module LocationSteps
  def current_path_should_be(expected_path)
    expected_searches = searches(expected_path)
    actual_searches = searches
    current_path = [current_pathname]
    if actual_searches.present?
      actual_searches.each do |k, v|
        actual_searches[k] = '*' if expected_searches[k] == '*'
      end
      current_path.push('?', CGI.unescape(actual_searches.to_query))
    end
    current_path = current_path.join
    expect(current_path).to eq(expected_path)
  end

  def current_pathname
    evaluate_script('location.pathname')
  end

  def current_search_should_have(search)
    expect(searches.symbolize_keys).to include(search)
  end

  def current_search_should_be(search)
    expect(searches.symbolize_keys).to eq(search)
  end

  def hard_reload!
    execute_script('location.reload()')
  end

  private
  def searches(query = evaluate_script('location.search'))
    return {} unless query.include?('?')
    searches = CGI::parse(query.split('?').last).map {|k, v| [k, v[0]]}.to_h
    sleep 1
    searches
  end
end