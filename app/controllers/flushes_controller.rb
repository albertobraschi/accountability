class FlushesController < ApplicationController
  make_resourceful do
    actions :all
    before(:new) do
      @sources = Source.find(:all).collect{|c| [c.title, c.id]}
    end
  end
end
