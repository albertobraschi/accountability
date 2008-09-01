class OutgoingCategoryAllocationsController < ApplicationController
  
  class NoParentSupplied < Exception 
  end
  
  before_filter :set_parent_context

  def new
    @allocation = @flush.outgoing_category_allocations.build     
  end

  protected
  def set_parent_context
    @flush = Flush.find(params[:flush_id])
  rescue ActiveRecord::RecordNotFound
    raise NoParentSupplied.new unless @flush
  end
end
