module PathHelper
  {
    root: '/',
    adverts: '/adverts',
    packages: '/packages',
    publishers: '/publishers',
    influencers: '/influencers',
    messages: '/messages',
    requests: '/requests'
  }.each do |name, path|
    define_method("#{name}_path") do |searches = nil|
      searches = CGI.unescape(searches.to_query) if searches
      result_path = ['/app', path]
      result_path << ['?', searches] if searches
      result_path.join
    end
  end

  def login_path
    '/login'
  end
end
