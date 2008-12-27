class AccountsController < ApplicationController

  before_filter :set_singular_context, :only => %w( show edit update destroy  ) 

  def index
    @accounts = Account.paginate(:all, :page => params[:page])
  end

  def show
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.create(params[:account])
    if @account.save
      flash[:notice] = "Account Created"
      new_path = accounts_path
    else
      flash[:error] =  @account.errors.full_messages
      new_path = new_account_path
    end
    redirect_to new_path
  end

  def edit
  end

  def update
    @account.update_attributes(params[:account])
    redirect_to account_path(@account.id)
  end

  def destroy
    @account.destroy!
    redirect_to accounts_path
  end

  protected 
  def set_singular_context
    @account = Account.find(params[:id])
  end
end
