class StatementsController <  ApplicationController
  before_filter :get_account
  before_filter :get_statement, :only => %w(edit update)
  
  def index
    @statements = @account.statements.paginate :page => params[:page], :order => :page_number
  end   
 
  def new
    @statement = @account.statements.build 
  end


  def edit
  end

  def update
    @statement.update_attributes(params[:statement] )
    redirect_to account_statements_path(@account)
  end

  def create
    @statement = @account.statements.build(params[:statement])     
    @statement.save!
    redirect_to account_statements_path(@account)
  end

  protected
  def get_account
    @account = Account.find(params[:account_id])
  end 

  def get_statement
    @statement = @account.statements.find(params[:id])
  end
end
