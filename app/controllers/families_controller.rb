class FamiliesController < ApplicationController
	before_action :set_family, only: [:show, :edit, :update, :destroy]
  # before_action :check_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
    authorize! :read, @family
    @active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    authorize! :read, @family
    @active_students = @family.students.active.alphabetical.to_a
    @inactive_students = @family.students.inactive.alphabetical.to_a
  end

  def new
    authorize! :new, @family
    @family = Family.new
    @family.students.build
  end

  def edit
    authorize! :update, @family
    if(@family.students.nil?)
      @family.students.build
    end
  end

  def create
    authorize! :new, @family
    @family = Family.new(family_params)
    if @family.save
      redirect_to @family, notice: "#{@family.family_name} family was added to the system"
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @family
    if @family.update(family_params)
      redirect_to @family, notice: "#{@family.family_name} family was revised in the system"
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @family
    @family.destroy
    if @family.destroy
      redirect_to families_url, notice: "#{@family.family_name} was removed from the system."
    else
      redirect_to families_url, notice: "Families cannot be deleted therefore, #{@family.family_name} was NOT removed from the system."
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active, student_attributes: [:first_name, :last_name, :date_of_birth, :rating, :active])
    end
end
