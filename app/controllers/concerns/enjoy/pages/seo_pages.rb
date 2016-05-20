module Enjoy::Pages::SeoPages
  extend ActiveSupport::Concern
  included do
    before_filter :find_page
  end

  private
  def find_page
    return if rails_admin?
    @seo_page = find_seo_page request.path
    if !@seo_page.nil? && !@seo_page.redirect.blank?
      redirect_to @seo_page.redirect, status: :moved_permanently
    end
  end

  def find_seo_page(path)
    do_redirect = false
    if path[0] != '/'
      path = '/' + path
    end
    if path.length > 1 && path[-1] == '/'
      path = path[0..-2]
      do_redirect = true
    end
    page = page_class.enabled.where(fullpath: path).first

    if page.nil? && !params[:slug].blank?
      page = page_class.enabled.where(fullpath: "/" + params[:slug]).first
    end

    if page.nil?
      page = find_seo_extra(path)
    end

    if page.nil?
      do_redirect = true
      spath = path.chomp(File.extname(path))
      if spath != path
        page = page_class.enabled.where(fullpath: spath).first
      end
    end

    if !page.nil? && do_redirect
      redirect_to path, status: :moved_permanently
    end

    page
  end

  def find_seo_page_with_redirect(path)
    do_redirect = false
    if path[0] != '/'
      path = '/' + path
    end
    if path.length > 1 && path[-1] == '/'
      path = path[0..-2]
      do_redirect = true
    end

    page = page_class.enabled.any_of({fullpath: path}, {redirect: path}).first
    if page.nil?
      do_redirect = true
      spath = path.chomp(File.extname(path))
      if spath != path
        page = page_class.enabled.any_of({fullpath: spath}, {redirect: spath}).first
      end
    end
    if !page.nil? && do_redirect
      redirect_to path, status: :moved_permanently
    end

    page

  end

  def find_seo_extra(path)
    nil
  end

  def page_class_name
    "Enjoy::Pages::Page"
  end
  def page_class
    page_class_name.constantize
  end

  def rails_admin?
    self.is_a?(RailsAdmin::ApplicationController) || self.is_a?(RailsAdmin::MainController)
  end
end
