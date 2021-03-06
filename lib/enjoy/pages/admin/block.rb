module Enjoy::Pages
  module Admin
    module Block
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('enjoy.pages')

          field :enabled, :toggle do
            searchable false
          end
          field :show_in_menu, :toggle do
            searchable false
          end
          field :partial, :toggle do
            searchable false
          end
          field :name do
            searchable true
          end
          field :menu_link_content, :text do
            searchable true
          end
          field :pageblock_selector, :string do
            searchable true
          end

          field :file_path, :string do
            searchable true
          end
          field :content, :enjoy_html do
            searchable true
          end

          group :wrapper do
            active false
            field :use_wrapper, :toggle
            field :wrapper_tag, :string
            field :wrapper_class, :string
            field :wrapper_id, :string
            field :wrapper_attributes, :text do
              formatted_value do
                bindings[:object] and bindings[:object].wrapper_attributes ? bindings[:object].wrapper_attributes.to_json : "{}"
              end
            end
          end

          # field :content_html, :ck_editor
          # field :content_clear, :toggle

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          # field :blocksets do
          #   read_only true
          #   help 'Список групп блоков'
          #
          #   pretty_value do
          #     bindings[:object].blocksets.to_a.map { |bs|
          #       route = (bindings[:view] || bindings[:controller])
          #       model_name = bs.rails_admin_model
          #       route.link_to(bs.name, route.rails_admin.show_path(model_name: model_name, id: bs.id), title: bs.name)
          #     }.join("<br>").html_safe
          #   end
          # end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
