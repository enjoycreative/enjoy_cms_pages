module Enjoy::Pages::Canonicalable
  extend ActiveSupport::Concern

  module ClassMethods
    def enjoy_canonical_fields(default = true)
      if Enjoy::Pages.mongoid?
        field :use_enjoy_canonicalable, type: Mongoid::Boolean, default: default
        belongs_to :enjoy_canonicalable, polymorphic: true
        field :enjoy_canonicalable_url, type: String, default: ""
      end
    end
  end

  included do
    enjoy_canonical_fields
    def enjoy_canonical_url(view_object)
      return enjoy_canonicalable_url unless enjoy_canonicalable_url.blank?
      return view_object.url_for enjoy_canonicalable unless enjoy_canonicalable.nil?
    end
  end

end
