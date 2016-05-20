module Enjoy::Pages
  module Admin
    module Blockset
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

          field :blocks do
            searchable :name
          end

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          # field :blocks do
          #   read_only true
          #   help 'Список блоков'
          #
          #   pretty_value do
          #     bindings[:object].blocks.to_a.map { |b|
          #       route = (bindings[:view] || bindings[:controller])
          #       model_name = b.rails_admin_model
          #       route.link_to(b.name, route.rails_admin.show_path(model_name: model_name, id: b.id), title: b.name)
          #     }.join("<br>").html_safe
          #   end
          # end

          sort_embedded(
              {
                  fields: [:blocks]
              }
          )

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
