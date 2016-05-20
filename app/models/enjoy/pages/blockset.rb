module Enjoy::Pages
  if Enjoy::Pages.mongoid?
    class Blockset
      include Enjoy::Pages::Models::Blockset

      include Enjoy::Pages::Decorators::Blockset

      rails_admin(&Enjoy::Pages::Admin::Blockset.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
