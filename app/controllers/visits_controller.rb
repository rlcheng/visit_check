class VisitsController < ApplicationController
  before_action :find_user
  before_action :find_visit, only: [:destroy]
  before_action :authorize

  def create
    count = @user.visits.count
    @visit = @user.visits.where(name: visit_params[:name])
      .first_or_create(visit_params)
    @visit.update(visit_params) if @user.visits.count == count
    redirect_to user_visits_path
  end

  def index
    @visits = @user.visits.order(:time)
  end

  def destroy
    @visit.destroy
    redirect_to user_visits_path
  end 

  private
    def find_user
      @user = User.find(params[:user_id])
    end

    def find_visit
      @visit = @user.visits.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:name, :time)
    end
end
