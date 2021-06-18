class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
  end

  private

  def search_payment
  end
end
