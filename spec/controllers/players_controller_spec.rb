require 'rails_helper'
require 'factories/players'
require 'factories/users'
require 'database_cleaner'

describe PlayersController do
	# For Devise >= 4.1.1
	include Devise::Test::ControllerHelpers
    # Use the following instead if you are on Devise <= 4.1.0
    # include Devise::TestHelpers

	RSpec.configure do |config|

	  config.before(:suite) do
	    DatabaseCleaner.clean_with(:truncation)
	  end

	  config.before(:each) do
	    DatabaseCleaner.start
	    sign_in create(:user)
	  end

	  config.after(:each) do
	    DatabaseCleaner.clean
	  end

	end

	describe "GET #index" do
	  it "populates an array of players" do
	    player = create(:player)

	    get :index
	    expect(assigns(:players)).to match_array([player])
	  end

	  it "renders the :index template" do
	    get :index
	    expect(response).to render_template :index
	  end
	end

	describe 'GET #edit' do
	    before :each do
	      @player = create(:player)
	    end

	    it "assigns the requested player to @player" do
	      get :edit, params: {id: @player.id}
	      expect(assigns(:player)).to eq @player
	    end

	    it "renders the :edit template" do
	      get :edit, params: {id: @player.id}
	      expect(response).to render_template :edit
	    end
	end

	describe 'GET #new' do
	    it "assigns a new player to @player" do
	      get :new
	      expect(assigns(:player)).to be_a_new(Player)
	    end

	    it "renders the :new template" do
	      get :new
	      expect(response).to render_template :new
	    end
	end

	describe 'DELETE #destroy' do
	    before :each do
	      @player = create(:player)
	    end

	    it "deletes the player from the database" do
	      expect{
	        delete :destroy, params: {id: @player.id}
	      }.to change(Player,:count).by(-1)
	    end

	    it "redirects to players#index" do
	      delete :destroy, params: {id: @player.id}
	      expect(response).to redirect_to players_path
	    end
	end

	describe 'PATCH #update' do
	    before :each do
	      @player = create(:player)
	    end

	    context "with valid attributes" do
	      it "locates the requested @player" do
	        patch :update, params: {id: @player, player: attributes_for(:player)}
	        expect(assigns(:player)).to eq(@player)
	      end

	      it "changes @player's attributes" do
	        patch :update, params: {id: @player,
	          player: attributes_for(:player,
	            name: 'Rivaldo',
	            number: '9')}
	        @player.reload
	        expect(@player.name).to eq('Rivaldo')
	        expect(@player.number).to eq('9')
	      end

	      it "redirects to the updated player" do
	        patch :update, params: {id: @player, player: attributes_for(:player)}
	        expect(response).to redirect_to players_path
	      end
	    end
	end
end