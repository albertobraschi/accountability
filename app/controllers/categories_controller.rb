class CategoriesController < ApplicationController
  before_filter :set_singular_context, :only => %w( show edit update destroy )
  before_filter :set_parent_context, :only => %w( create update )

  def index
    @categories = Category.paginate(:all, :page => params[:page])
  end
 
  def show
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def create

    @category = Category.new(params[:category])
    @category.type = params[:category][:type]
    @category.save!
    @category.move_to_child_of @requested_parent if @requested_parent
    redirect_to categories_path 

  rescue Exception => e
    flash[:error] = e.record.errors.full_messages
    redirect_to new_category_path
  end

  def update
    if @category.update_attributes(params[:category])
       @category.move_to_child_of @requested_parent if @requested_parent
       rpath = categories_path
    else
       rpath = edit_category_path
    end
    redirect_to rpath
  end

  def destroy
    begin
      @category.destroy
      flash[:notice] = "Category #{@category.name} destroyed"
    rescue Exception => e
      flash[:error] = @category.errors.full_messages
    end
    redirect_to categories_path 
  end

  protected
  def set_parent_context
    parent_id = params[:category][:parent_id] if params[:category]
    @requested_parent = Category.find(parent_id) unless parent_id.blank?
  end

  def set_singular_context
    @category = Category.find(params[:id])
  end
end
