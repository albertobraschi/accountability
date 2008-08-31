class OutgoingCategoriesController < ApplicationController
  before_filter :set_singular_context, :only => %w( show edit update destroy )

  def index
    @outgoing_categories = OutgoingCategory.paginate(:all, :page => params[:page])
  end
 
  def show
  end

  def edit
  end

  def new
    @outgoing_category = OutgoingCategory.new
  end

  def create
    @outgoing_category = OutgoingCategory.create!(params[:outgoing_category])
    redirect_to outgoing_categories_path
  rescue
    redirect_to new_outgoing_category_path
  end

  def update
    if @outgoing_category.update_attributes(params[:outgoing_category])
       rpath = outgoing_categories_path
    else
       rpath = edit_outgoing_category_path
    end
    redirect_to rpath
  end

  def destroy
    if @outgoing_category.destroy
      flash[:notice] = "Category #{@outgoing_category.title} destroyed"
    end
  end

  protected
  def set_singular_context
    @outgoing_category = OutgoingCategory.find(params[:id])
  end
end
