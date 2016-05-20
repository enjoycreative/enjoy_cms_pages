module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_pages_routes(config = {})
      routes_config = {
        use_slug_path: true,
        use_pages_path: true,
        classes: {
          pages: :pages
        },
        paths: {
          pages: :pages
        }
      }
      routes_config.deep_merge!(config)

      generate_enjoy_pages_user_routes(routes_config)
      generate_enjoy_pages_cms_routes(routes_config)

    end


    private
    def generate_enjoy_pages_user_routes(routes_config)
      if !routes_config[:use_pages_path] and !routes_config[:classes][:pages].nil?
        resources routes_config[:classes][:pages].to_sym, only: [:show], path: routes_config[:paths][:pages]
      end
      if !routes_config[:use_slug_path] and !routes_config[:classes][:pages].nil?
        get '*slug' => "#{routes_config[:classes][:pages]}#show"
      end
    end
    def generate_enjoy_pages_cms_routes(routes_config)
      scope module: 'enjoy' do
        scope module: 'pages' do
          if routes_config[:use_pages_path] and !routes_config[:classes][:pages].nil?
            resources routes_config[:classes][:pages].to_sym, only: [:show], path: routes_config[:paths][:pages], as: :enjoy_pages
          end
          if routes_config[:use_slug_path] and !routes_config[:classes][:pages].nil?
            get '*slug' => "#{routes_config[:classes][:pages]}#show"
          end
        end
      end
    end

  end
end
