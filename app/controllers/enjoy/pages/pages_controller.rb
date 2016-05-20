module Enjoy::Pages
  class PagesController < ApplicationController
    include Enjoy::Pages::Controllers::Pages

    include Enjoy::Pages::Decorators::PagesController
  end
end
