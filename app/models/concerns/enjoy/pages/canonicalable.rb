module Enjoy::Pages::Canonicalable
  extend ActiveSupport::Concern

  module ClassMethods
    def enjoy_canonical_fields(default = true)
      if Enjoy::Pages.mongoid?
        field :use_enjoy_canonicable, type: Mongoid::Boolean, default: default
        belongs_to :enjoy_canonicable, polymorphic: true
        field :enjoy_canonicable_url, type: String, default: ""
      end
    end
  end

  included do
    enjoy_canonical_fields
    def enjoy_canonical_url(view_object)
      return enjoy_canonicable_url unless enjoy_canonicable_url.blank?
      return view_object.url_for enjoy_canonicable unless enjoy_canonicable.nil?
    end
  end

end
