module Enjoy::Pages
  module Models
    module Page
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include ManualSlug
      if Enjoy::Pages.config.seo_support
        include Enjoy::Seo::Seoable
        include Enjoy::Seo::SitemapDataField
      end

      include Enjoy::Pages.orm_specific('Page')

      # if Enjoy.config.search_enabled
      #   include Enjoy::ElasticSearch
      # end

      included do
        acts_as_nested_set

        validates_uniqueness_of :fullpath
        validates_presence_of :name
        manual_slug :name
        before_validation do
          self.fullpath = "/pages/#{slug}" if self.fullpath.blank?
        end

        belongs_to :connectable, polymorphic: true

        before_save do
          self.connectable_id = nil   if self.connectable_type.nil?
          self.connectable_type = nil if self.connectable_id.nil?
          self
        end
      end

      def page_h1
        _ret = seo ? seo.h1 : nil
        _ret = name   if _ret.blank?
        _ret = title  if _ret.blank?
        _ret
      end

      def get_fullpath
        redirect.blank? ? fullpath : redirect
      end

      def has_content?
        @content_used.nil? && !content.blank?
      end

      def page_content
        if @content_used.nil?
          @content_used = true
          if content.nil?
            ''
          else
            content.gsub(/\{\{(.*?)\}\}/) do
              Settings ? Settings.get($1).val : "" #temp
            end
          end
        else
          ''
        end
      end

      def is_current?(url)
        if fullpath == '/'
          url == '/'
        else
          url.match(clean_regexp)
        end
      end

      def regexp_prefix
        Enjoy::Pages.config.localize ? "(?:#{I18n.available_locales.map { |l| "\\/#{l}"}.join("|")})?" : ""
      end

      def clean_regexp
        if regexp.blank?
          /^#{regexp_prefix}#{Regexp.escape(fullpath)}$/
        else
          begin
            /#{regexp}/
          rescue
            # not a valid regexp - treat as literal search string
            /#{Regexp.escape(regexp)}/
          end
        end
      end

      def nav_options
        nav_options_default.merge(nav_options_additions)
      end

      def nav_options_default
        {highlights_on: clean_regexp}
      end

      def nav_options_additions
        {}
      end
    end
  end
end
