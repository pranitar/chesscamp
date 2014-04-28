class RegistrationsController < ApplicationController
	before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
    @active_registrations = Registration.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_registrations = Registration.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @camps = @registration.camps.chronological.to_a
  end

  def new
    @registration = Registration.new
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration, notice: "#{@registration.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: "#{@registration.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: "#{@registration.name} was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end
