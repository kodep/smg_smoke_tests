module RequestHelper
  # args:
  # '/publishers', q: {...}      - GET
  # 'PATCH', '/publishers/*/users', {publisher: {...}}    - * is any number
  def expect_request(*args)
    request = read_expected_request(*args)
    requests = evaluate_script('window.requestCollector')
    is_exist_request = true
    requests.each do |r|
      is_exist_request = true
      is_exist_request &= r['method'] == request['method'] if request['method']
      is_exist_request &= r['url'].gsub(/\/\d+/, '/*').gsub(/\=\d+/, '=%2A') == request['url'] if request['url']
      is_exist_request &= r['data'].deep_merge(request['data']) == r['data'] if request['data']
      break if is_exist_request
    end
    unless is_exist_request
      puts 'All requests:'
      p requests
      puts 'Expected request:'
      p request
    end
    expect(is_exist_request).to be true
  end

  private
  def read_expected_request(*args)
    JSON[
      if args[0].instance_of?(Hash)
        args[0]
      elsif args[0].instance_of?(String) && (args.size == 1 || args.size == 2 && args[1].instance_of?(Hash))
        url = args[0]
        url << "?#{args[1].to_param}"
        {method: 'GET', url: url}
      elsif args.size == 3
        {method: args[0], url: args[1], data: args[2]}
      end.to_json
    ]
  end
end
