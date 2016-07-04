module Enjoy::Pages::Blocksetable
  extend ActiveSupport::Concern
  included do
    helper_method :render_blockset
    helper_method :blockset_navigation
  end

  private
  def blockset_navigation(type)
    Proc.new do |primary|
      SimpleNavigation.config.autogenerate_item_ids = false
      begin
        blockset_nav_extra_data_before(type, primary)
        all_items = blockset_nav_get_menu_items(type)
        items = all_items#.select { |i| i.parent_id.nil? && !i.name.blank? && i.enabled }
        items.each do |item|
          # render_with_subs(all_items, primary, item)
          blockset_navigation_item(primary, item)
        end
        blockset_nav_extra_data_after(type, primary)
      rescue Exception => exception
        Rails.logger.error exception.message
        Rails.logger.error exception.backtrace.join("\n")
        puts exception.message
        puts exception.backtrace.join("\n")
        capture_exception(exception) if respond_to?(:capture_exception)
        items || []
      end
    end
  end

  def render_blockset(view, type)
    ret = []
    begin
      blocks = blockset_get_blocks(type)
      blocks.each do |block|
        ret << block.render_or_content_html(view) do |html|
          render_blockset_block block, html
        end
      end
    rescue Exception => exception
      Rails.logger.error exception.message
      Rails.logger.error exception.backtrace.join("\n")
      puts exception.message
      puts exception.backtrace.join("\n")
      capture_exception(exception) if respond_to?(:capture_exception)
      # ret << blocks || []
    end
    ret.join.html_safe
  end

  def render_blockset_block(block, html)
    html
  end

  def blockset_get_blocks(type)
    blockset = blockset_class.find(type.to_s)
    blockset.blocks.enabled.show_in_menu.sorted.to_a if blockset
  end

  def blockset_class_name
    "Enjoy::Pages::Blockset"
  end
  def blockset_class
    blockset_class_name.constantize
  end

  def blockset_navigation_item(primary, item, block=nil)
    url = item.pageblock_selector.blank? ? item.slug : item.pageblock_selector #"javascript:;"
    content = item.menu_link_content.blank? ? item.name : item.menu_link_content.html_safe
    if block.nil?
      primary.item(item.slug, content, url, item.nav_options)
    else
      primary.item(item.slug, content, url, item.nav_options, &block)
    end
  end

  def blockset_nav_get_menu_items(type)
    blockset_get_blocks(type)
  end
  def blockset_nav_extra_data_before(type, primary)
    # override for additional config or items
  end
  def blockset_nav_extra_data_after(type, primary)
    # override for additional config or items
  end
end
