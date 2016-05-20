module Enjoy::Pages
  if Enjoy::Pages.active_record?
    class Page < ActiveRecord::Base
    end
  end

  class Page
    include Enjoy::Pages::Models::Page

    include Enjoy::Pages::Decorators::Page

    rails_admin(&Enjoy::Pages::Admin::Page.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
