class OutgoingsController < ApplicationController
  make_resourceful do
    actions :all
    before(:edit, :new) do
      @accounts = Account.find(:all).collect{|c| [c.title, c.id]}
    end
    before(:edit, :show, :update) do
      @account = Account.find(@incoming.account_id)
    end
  end
end
