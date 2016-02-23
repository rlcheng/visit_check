require 'rails_helper'

describe 'apps', type: :request do
  let(:visit_params) { { visit: { name: "Site", time: 2.0 } } }
  let(:visit_params2) { { visit: { name: "Site2", time: 1.0 } } }
  let(:update_visit_params) { { visit: { name: "Site", time: 3.0 } } }
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { email: user.email, password: user.password } }

  context "when logged out" do
    it "should not allow access to visits index" do
      post '/visits'
      expect(response).to redirect_to '/log_in'
    end
  end

  context "when logged in" do
    before do
      post '/log_in', user_params
      expect(response).to have_http_status(302)
    end

    describe "Post create /visits" do
      it "should create a new visit" do
        expect{
          post '/visits', visit_params
        }.to change(Visit, :count).by(1)
      end

      it "should update instead of create if visit_params exists" do
        post '/visits', visit_params
        expect{
          post '/visits', update_visit_params
        }.to change(Visit, :count).by(0) 
        expect(Visit.last.time).to eq(update_visit_params[:visit][:time])
      end
    end

    describe "visits index page" do
      it "should render the visits index page" do
        post '/visits', visit_params
        post '/visits', visit_params2
        get '/visits'
        expect(response).to have_http_status(200)
        expect(response).to render_template('index')
      end
    end

    describe "Destroy /visit/1" do
      it "should destroy all visits" do
        post '/visits', visit_params
        post '/visits', visit_params2
        expect{
          delete '/visits/2'
        }.to change(Visit, :count).by(-1)
        expect(response).to redirect_to visits_path
      end
    end
  end
end
