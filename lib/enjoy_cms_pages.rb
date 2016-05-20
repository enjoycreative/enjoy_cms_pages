unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord"
  puts "also: please use enjoy_cms_news_mongoid or enjoy_cms_news_activerecord and not enjoy_cms_news directly"
  exit 1
end

require "enjoy/pages/version"
require 'enjoy/pages/engine'
require 'enjoy/pages/configuration'

require "enjoy/pages/routes"

require 'enjoy/pages/rails_admin_ext/enjoy_connectable'
require 'enjoy/pages/rails_admin_ext/menu'

require 'simple-navigation'

module Enjoy::Pages
  class << self
    def orm
      Enjoy.orm
    end
    def mongoid?
      Enjoy::Pages.orm == :mongoid
    end
    def active_record?
      Enjoy::Pages.orm == :active_record
    end
    def model_namespace
      "Enjoy::Pages::Models::#{Enjoy::Pages.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  autoload :Admin, 'enjoy/pages/admin'
  module Admin
    autoload :Page, 'enjoy/pages/admin/page'
    autoload :Menu, 'enjoy/pages/admin/menu'
    autoload :Block, 'enjoy/pages/admin/block'
    autoload :Blockset, 'enjoy/pages/admin/blockset'
  end

  module Models
    autoload :Page, 'enjoy/pages/models/page'
    autoload :Menu, 'enjoy/pages/models/menu'
    autoload :Block, 'enjoy/pages/models/block'
    autoload :Blockset, 'enjoy/pages/models/blockset'

    module Mongoid
      autoload :Page, 'enjoy/pages/models/mongoid/page'
      autoload :Menu, 'enjoy/pages/models/mongoid/menu'
      autoload :Block, 'enjoy/pages/models/mongoid/block'
      autoload :Blockset, 'enjoy/pages/models/mongoid/blockset'
    end

    module ActiveRecord
      autoload :Page, 'enjoy/pages/models/active_record/page'
      autoload :Menu, 'enjoy/pages/models/active_record/menu'
      autoload :Block, 'enjoy/pages/models/active_record/block'
      autoload :Blockset, 'enjoy/pages/models/active_record/blockset'
    end
  end

  module Controllers
    autoload :Pages, 'enjoy/pages/controllers/pages'
  end

end
