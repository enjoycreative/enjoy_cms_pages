module Enjoy::Pages
  module Models
    module Mongoid
      module Blockset
        extend ActiveSupport::Concern

        included do
          field :name, type: String, default: ""

          embeds_many :blocks, inverse_of: :blockset, class_name: "Enjoy::Pages::Block"
          accepts_nested_attributes_for :blocks, allow_destroy: true
        end
      end
    end
  end
end
