require 'rails_helper'

describe 'apps', type: :request do
  let(:app_params) { { app: { name: "Site", resource_url: "Site.com" } } }
  let(:app_params2) { { app: { name: "Site2", resource_url: "Site2.com" } } }
  let(:bad_app_params) { { app: { name: "", resource_url: "" } } }
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { email: user.email, password: user.password } }

  context "when logged out" do
    it "should not allow access to apps index" do
      post '/apps'
      expect(response).to redirect_to '/log_in'
    end
  end

  context "when logged in" do
    before do
      post '/log_in', user_params
      expect(response).to have_http_status(302)
    end

    describe "Get /apps/new" do
      it "should render the games new page" do
        get '/apps/new'
        expect(response).to have_http_status(200)
        expect(response).to render_template('new')
      end
    end

    describe "Post create /apps" do
      it "should create a new game and redirect to show game" do
        expect{
          post '/apps', app_params
        }.to change(App, :count).by(1)
        expect(response).to redirect_to '/apps/1'
      end

      it "should not create a new app with bad params" do
        post '/apps', bad_app_params
        expect(response).to render_template('new')
      end
    end

    describe "Show app" do
      it "should show app" do
        post '/apps', app_params
        post '/apps', app_params
        get '/apps/2'
        expect(response).to have_http_status(200)
      end
    end

    describe "games index page" do
      it "should render the games index page" do
        get '/apps'
        expect(response).to have_http_status(200)
        expect(response).to render_template('index')
      end
    end

    describe "Edit /app/1" do
      it "should render edit page" do
        post '/apps', app_params
        get '/apps/1/edit'
        expect(response).to have_http_status(200)
      end
    end

    describe "Update /app/1" do
      before(:each) { post '/apps', app_params }

      it "should update app" do
        patch '/apps/1', app_params2
        expect(response).to redirect_to '/apps/1'
      end

      it "should not update with bad params" do
        patch '/apps/1', bad_app_params
        expect(response).to render_template 'edit'
      end
    end

    describe "Destroy /app/1" do
      before(:each) do
        post '/apps', app_params
        post '/apps', app_params2
      end

      it "should destroy a app" do
        expect{
          delete '/apps/2'
        }.to change(App, :count).by(-1)
        expect(response).to redirect_to apps_path
      end
    end
  end
end
