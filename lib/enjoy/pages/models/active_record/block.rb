module Enjoy::Pages
  module Models
    module ActiveRecord
      module Block
        extend ActiveSupport::Concern

        # include Enjoy::HtmlField

        included do
          belongs_to :blockset, class_name: "Enjoy::Pages::Block"
        end

      end
    end
  end
end
