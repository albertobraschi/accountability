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

  rescue Exception => e
    flash[:error] = e.record.errors.full_messages
    redirect_to new_outgoing_category_path

  end

  def update
    if @outgoing_category.update_attributes(params[:outgoing_category])
       @outgoing_category.move_to_child_of @requested_parent
       rpath = outgoing_categories_path
    else
       rpath = edit_outgoing_category_path
    end
    redirect_to rpath
  end

  def destroy
    begin
      @outgoing_category.destroy
      flash[:notice] = "Category #{@outgoing_category.name} destroyed"
    rescue Exception => e
      flash[:error] = @outgoing_category.errors.full_messages
    end
    redirect_to outgoing_categories_path 
  end

  protected
  def set_singular_context
    parent_id = params[:outgoing_category][:parent_id] if params[:outgoing_category]
    @requested_parent = OutgoingCategory.find(parent_id) if parent_id
    @outgoing_category = OutgoingCategory.find(params[:id])
  end
end
