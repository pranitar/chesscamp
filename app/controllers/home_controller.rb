class HomeController < ApplicationController
  def index
  	if logged_in?
  		if current_user.role? :admin
  	  		@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  	  		@active_instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	  		@students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	  		@families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	  	else
  	  		# get my camps
  	  		@upcoming_camps = current_user.instructor.camps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  	  	end
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
