class OutgoingCategoryAllocationsController < ApplicationController
  
  class NoParentSupplied < Exception 
  end
  
  before_filter :set_parent_context

  def new
    @outgoing_category_options = OutgoingCategory.find(:all).collect{|oc| [oc.name, oc.id]}
    @outgoing_category_allocation = @outgoing.outgoing_category_allocations.build     
  end

  def show
  end

  def create
    @outgoing_category_allocation = @outgoing.outgoing_category_allocations.create(params[:outgoing_category_allocation])
    render :action => :show
  end

  protected
  def set_parent_context
    @outgoing = Outgoing.find(params[:outgoing_id])
  rescue ActiveRecord::RecordNotFound
    raise NoParentSupplied.new unless @outgoing
  end
end
