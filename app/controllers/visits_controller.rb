class VisitsController < ApplicationController
  before_action :find_visit, only: [:destroy]
  before_action :authorize

  def create
    count = Visit.count
    @visit = Visit.where(name: visit_params[:name])
      .first_or_create(visit_params)
    @visit.update(visit_params) if Visit.count == count
    redirect_to visits_path
  end

  def index
    @visits = Visit.order(:time)
  end

  def destroy
    @visit.destroy
    redirect_to visits_path
  end 

  private
    def find_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:name, :time)
    end
end
