module Enjoy::Pages
  module Models
    module Blockset
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include ManualSlug

      include Enjoy::Pages.orm_specific('Blockset')

      included do
        manual_slug :name
      end

    end
  end
end
