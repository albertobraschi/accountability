class SourcesController < ApplicationController

  before_filter :set_singular_context, :only => %w( show edit update destroy  ) 

  def index
    @sources = Source.paginate(:all, :page => params[:page])
  end

  def show
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.create(params[:source])
    if @source.save
      flash[:notice] = "Transaction Created"
      new_path = sources_path
    else
      flash[:error] =  @source.errors.full_messages
      new_path = new_source_path
    end
    redirect_to new_path
  end

  def edit
  end

  def update
    @source.update_attributes(params[:source])
    redirect_to source_path(@source.id)
  end

  def destroy
    @source.destroy!
    redirect_to sources_path
  end

  protected 
  def set_singular_context
    @source = Source.find(params[:id])
  end
end
