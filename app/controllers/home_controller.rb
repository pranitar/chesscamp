class HomeController < ApplicationController
  def index
  	if logged_in?
  		if current_user.role? :admin
  	  		@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  	  		@active_instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	  		@students = Student.active.alphabetical.all
  	  		@families = Family.active.alphabetical.all
  	  	else
  	  		# get my camps
  	  		@upcoming_camps = current_user.instructor.camps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
      
      		# get my incomplete tasks
      		# @incomplete_tasks = Task.by_priority.incomplete.map{|task| task if project_ids.include?(task.project_id)}
      
      		# get my completed tasks
      		# @completed_tasks = Task.by_name.completed.map {|task| task if project_ids.include?(task.project_id) }
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
