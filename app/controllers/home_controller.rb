class HomeController < ApplicationController

  def index
  	if therapist_signed_in?
  		redirect_to therapist_index_path
  	end
  end
  
end
