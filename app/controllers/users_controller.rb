class UsersController < ApplicationController
	before_action :authorize!

  def index
    render jsonapi: User.all
  end

  def archive_unarchive
  	users = User.where('email!=?',params[:email])
  	date = Date.today.to_s
  	CSV.open("myfile1.csv", "w") do |csv|
  		csv<< ['email', 'created_at', 'created_by']
  		users.each do |user|
			csv << [user[:email], date, params[:email]]
			UserMailer.with(user: user).welcome_email.deliver_later
		end
	end
	render json: { :status => "ok"}
  end
end
