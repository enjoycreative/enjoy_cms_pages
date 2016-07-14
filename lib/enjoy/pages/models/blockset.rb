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


      def render(view, content = "")
        ret = content
        if use_wrapper
          _attrs = {
            class: wrapper_class,
            id: wrapper_id
          }.merge(wrapper_attributes)
          ret = view.content_tag wrapper_tag, ret, _attrs
        end
        ret = yield ret if block_given?
        return ret
      end

      # def wrapper_attributes=(val)
      #   if val.is_a? (String)
      #     begin
      #       begin
      #         self[:wrapper_attributes] = JSON.parse(val)
      #       rescue
      #         self[:wrapper_attributes] = YAML.load(val)
      #       end
      #     rescue
      #     end
      #   elsif val.is_a?(Hash)
      #     self[:wrapper_attributes] = val
      #   else
      #     self[:wrapper_attributes] = wrapper_attributes
      #   end
      # end


    end
  end
end
