module Enjoy::Pages
  module Models
    module Block
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include ManualSlug

      include Enjoy::Pages.orm_specific('Block')

      included do
        manual_slug :name

        validates :file_path, format: {
          # with: /\A(?!layouts\/).*\Z/,
          without: /\Alayouts\/.*\Z/,
          message: "Недопустимый путь к файлу"
        }

        attr_accessor :file_pathname
        after_initialize do
          self.file_pathname = Pathname.new(file_path) unless file_path.nil?
        end
      end

      def file_pathname_as_partial
        self.file_pathname.dirname.join("_#{self.file_pathname.basename}")
      end

      def file_pathname_for_fs
        self.partial ? self.file_path_as_partial : self.file_pathname
      end

      def render_or_content_html(view, opts = {})
        unless self.file_path.blank?
          opts.merge!(partial: self.file_path)
          view.render(opts) rescue self.content_html.html_safe
        else
          self.content_html.html_safe
        end
      end

      def render_or_content(view, opts = {})
        unless self.file_path.blank?
          opts.merge!(partial: self.file_path)
          view.render(opts) rescue self.content
        else
          self.content
        end
      end

      def file_fullpath(with_ext = false, ext = ".html.slim")
        ret = nil
        unless self.file_path.blank?
          res_filename = self.file_pathname_for_fs.to_s
          res_filename += ext if with_ext
          ret = Rails.root.join("views", res_filename)
        end
        return ret
      end

      def nav_options
        nav_options_default.merge(nav_options_additions)
      end

      def nav_options_default
        {
          highlights_on: false,
          link_html: {
            data: {
              pageblock_selector: self.pageblock_selector
            }
          }
        }
      end

      def nav_options_additions
        {}
      end
    end
  end
end
