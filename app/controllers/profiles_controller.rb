class ProfilesController < ApplicationController
  before_action :get_header_category_brand
  add_breadcrumb 'メルカリ', '/'

  def index
    add_breadcrumb " "
  end

  private
  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.roots
    @categories.each do |large|
      large.children.limit(14).each do |middle|
        @categories+= [middle]
        middle.children.limit(14).each do |small|
          @categories+= [small]
        end
      end
    end
  end
end
