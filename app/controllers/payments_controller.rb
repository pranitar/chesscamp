class PaymentsController < ApplicationController
  def index
    @active_camps = Camp.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @families = Family.alphabetical.paginate(:page => params[:page]).per_page(10)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name"
      end
    end
  end
end




