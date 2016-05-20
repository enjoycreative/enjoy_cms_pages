module Enjoy::Pages
  module Models
    module ActiveRecord
      module Blockset
        extend ActiveSupport::Concern

        included do
          has_paper_trail
          validates_lengths_from_database only: [:name]
          if Enjoy::Pages.config.localize
            translates :name
          end

          has_many :page_blocks, class_name: "Enjoy::Pages::Blockset"
        end
      end
    end
  end
end
