module Enjoy::Pages
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :menu_max_depth

    attr_accessor :seo_support

    attr_accessor :localize

    def initialize
      @menu_max_depth = 2

      @seo_support = defined? Enjoy::Seo

      @localize   = Enjoy.config.localize
    end
  end
end
