module Enjoy::Pages
  module Admin
    module Menu
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('enjoy.pages')

          field :enabled, :toggle do
            searchable false
          end
          field :text_slug do
            searchable true
          end
          field :name do
            searchable true
          end

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
