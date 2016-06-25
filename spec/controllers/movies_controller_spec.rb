require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  let(:valid_attributes) {
    { title: "Finding Dory" }
  }

  let(:invalid_attributes) {
    { title: nil }
  }

  describe "GET #index" do
    it "assigns all movies as @movies" do
      movie = Movie.create! valid_attributes
      get :index, {}

      expect(assigns(:movies)).to eq([movie])
    end
  end

  describe "GET #show" do
    it "assigns the requested movie as @movie" do
      movie = Movie.create! valid_attributes
      get :show, {:id => movie.to_param}

      expect(assigns(:movie)).to eq(movie)
    end
  end

  describe "GET #new" do
    it "assigns a new movie as @movie" do
      get :new, {}

      expect(assigns(:movie)).to be_a_new(Movie)
    end
  end

  describe "GET #edit" do
    it "assigns the requested movie as @movie" do
      movie = Movie.create! valid_attributes
      get :edit, {:id => movie.to_param}

      expect(assigns(:movie)).to eq(movie)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, {:movie => valid_attributes}
        }.to change(Movie, :count).by(1)
      end

      it "assigns a newly created movie as @movie" do
        post :create, {:movie => valid_attributes}

        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
      end

      it "redirects to the created movie" do
        post :create, {:movie => valid_attributes}

        expect(response).to redirect_to(Movie.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        post :create, {:movie => invalid_attributes}

        expect(assigns(:movie)).to be_a_new(Movie)
      end

      it "re-renders the 'new' template" do
        post :create, {:movie => invalid_attributes}

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'new title'}
      }

      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => new_attributes}
        movie.reload

        expect(movie.title).to eq 'new title'
      end

      it "assigns the requested movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}

        expect(assigns(:movie)).to eq(movie)
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}

        expect(response).to redirect_to(movie)
      end
    end

    context "with invalid params" do
      it "assigns the movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => invalid_attributes}

        expect(assigns(:movie)).to eq(movie)
      end

      it "re-renders the 'edit' template" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => invalid_attributes}

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete :destroy, {:id => movie.to_param}
      }.to change(Movie, :count).by(-1)
    end

    it "redirects to the movies list" do
      movie = Movie.create! valid_attributes
      delete :destroy, {:id => movie.to_param}

      expect(response).to redirect_to(movies_url)
    end
  end
end
