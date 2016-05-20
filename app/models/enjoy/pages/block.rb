module Enjoy::Pages
  if Enjoy::Pages.mongoid?
    class Block < Enjoy::EmbeddedElement
      include Enjoy::Pages::Models::Block

      include Enjoy::Pages::Decorators::Block

      rails_admin(&Enjoy::Pages::Admin::Block.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
