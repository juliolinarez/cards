require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:test_post) { create(:post) }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { { title: nil, content: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all posts' do
      post1 = create(:post)
      post2 = create(:post)
      get :index
      expect(assigns(:posts)).to match_array([ post1, post2 ])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: test_post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: test_post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Post' do
        expect {
          post :create, params: { post: invalid_attributes }
        }.not_to change(Post, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Title', content: 'Updated Content for testing' } }

      it 'updates the requested post' do
        put :update, params: { id: test_post.to_param, post: new_attributes }
        test_post.reload
        expect(test_post.title).to eq('Updated Title')
        expect(test_post.content).to eq('Updated Content for testing')
      end

      it 'redirects to the post' do
        put :update, params: { id: test_post.to_param, post: valid_attributes }
        expect(response).to redirect_to(test_post)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        put :update, params: { id: test_post.to_param, post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post_to_delete = create(:post)
      expect {
        delete :destroy, params: { id: post_to_delete.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      delete :destroy, params: { id: test_post.to_param }
      expect(response).to redirect_to(posts_url)
    end
  end
end
