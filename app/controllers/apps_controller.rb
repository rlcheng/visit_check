class AppsController < ApplicationController
  before_action :find_app, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)

    if @app.save
      redirect_to @app
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @apps = App.all
  end

  def edit
  end

  def update
    if @app.update(app_params)
      redirect_to @app
    else
      render 'edit'
    end
  end

  def destroy
    @app.destroy

    redirect_to apps_path
  end  

  private
    def find_app
      @app = App.find(params[:id])
    end

    def app_params
      params.require(:app).permit(:name, :resource_url)
    end
end
