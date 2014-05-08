class RegistrationsController < ApplicationController
	before_action :set_registration, only: [:show, :edit, :update, :destroy]
  # before_action :check_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
  end

  def show
  end

  def new
    # authorize! :new, @registration
    @registration = Registration.new
  end

  def edit
    authorize! :update, @registration
  end

  def create
    authorize! :new, @registration
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration, notice: "This registration was added to the system."
    else
      flash[:warning] = "Cannot register - student has either already been enrolled or is not eligible"
      render action: 'new'
    end
  end

  def update
    authorize! :update, @registration
    if @registration.update(registration_params)
      redirect_to @registration, notice: "This registration was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @registration
    @registration.destroy
    redirect_to registrations_url, notice: "This registration was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end
