class EmailsController < ApplicationController

  def create
  	@email = Myemail.new(email: params[:email])
  	if @email.save then
  		render json: @email
  	else
  		render json: @email.errors, status: :unprocessable_entity
  	end
  end

end
