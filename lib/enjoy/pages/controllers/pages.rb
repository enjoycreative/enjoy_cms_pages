module Enjoy::Pages
  module Controllers
    module Pages
      extend ActiveSupport::Concern
      def show
        if @seo_page.nil? || !@seo_page.persisted?
          if !params[:id].blank? or !params[:slug].blank?
            @seo_page = model.enabled.find(params[:id] || params[:slug])
          end
        end
        after_initialize
        if @seo_page.nil?
          render_404
          return true
        end

        if Enjoy::Pages.config.breadcrumbs_on_rails_support
          add_breadcrumb @seo_page.name, @seo_page.slug
        end
      end

      private
      def model
        Enjoy::Pages::Page
      end

      def after_initialize
      end
    end
  end
end
