class OutgoingsController < ApplicationController
  make_resourceful do
    actions :all
    before(:edit, :new) do
      @sources = Account.find(:all).collect{|c| [c.title, c.id]}
    end
  end
end
