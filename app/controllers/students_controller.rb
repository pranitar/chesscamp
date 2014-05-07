class StudentsController < ApplicationController
	before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, @student
    @active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    authorize! :read, @student
    @camps = @student.camps.chronological
    @upcoming_camps = @student.camps.upcoming.chronological
    @past_camps = @student.camps.past.chronological
  end

  def new
    authorize! :new, @student
    @student = Student.new
  end

  def edit
    authorize! :update, @student
  end

  def create
    authorize! :new, @student
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "#{@student.first_name} #{@student.last_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @student
    if @student.update(student_params)
      redirect_to @student, notice: "#{@student.first_name} #{@student.last_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @student
    @student.destroy
    redirect_to students_url, notice: "#{@student.first_name} #{@student.last_name} was removed from the system."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end
