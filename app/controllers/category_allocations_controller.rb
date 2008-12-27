class CategoryAllocationsController < ApplicationController
  
  class NoParentSupplied < Exception 
  end
  
  before_filter :set_parent_context

  def new
    @category_options = Category.find(:all).collect{|oc| [oc.name, oc.id]}
    @category_allocation = @transaction.category_allocations.build     
  end

  def show
  end

  def create
    @category_allocation = @transaction.category_allocations.create(params[:category_allocation])
    render :action => :show
  end

  protected
  def set_parent_context
    #TODO:Refactor
    if params[:outgoing_id]
      @transaction = Outgoing.find(params[:outgoing_id])
    else
      @transaction = Incoming.find(params[:incoming_id])
    end
  rescue ActiveRecord::RecordNotFound
    raise NoParentSupplied.new unless @transaction
  end
end
