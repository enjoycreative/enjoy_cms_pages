module Enjoy::Pages
  module Models
    module Menu
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include ManualSlug

      include Enjoy::Pages.orm_specific('Menu')

      included do
        manual_slug :name

        after_save do
          Rails.cache.delete 'menus'
        end
        after_destroy do
          Rails.cache.delete 'menus'
        end
      end
    end
  end
end
