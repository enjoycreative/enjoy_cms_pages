module Enjoy::Pages
  if Enjoy::Pages.active_record?
    class Menu < ActiveRecord::Base
    end
  end

  class Menu
    include Enjoy::Pages::Models::Menu

    include Enjoy::Pages::Decorators::Menu

    rails_admin(&Enjoy::Pages::Admin::Menu.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
