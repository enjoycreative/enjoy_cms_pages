module Enjoy::Pages::CanonicalHelper
  def enjoy_canonical_tag(url = "")
    return if url.blank?
    tag(:link, href: url, rel: :canonical)
  end

  def enjoy_canonical_tag_for(obj)
    return if obj.use_enjoy_canonicable
    url = obj.enjoy_canonicable_url
    url = url_for(obj.enjoy_canonicable) if !url.blank? and obj.enjoy_canonicable
    enjoy_canonical_tag(url) if url.blank?
  end
end
