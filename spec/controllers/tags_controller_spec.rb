require 'rails_helper'

describe TagsController do
  describe 'GET list of publications' do
    let(:tag_1) { create(:tag) }
    let(:tag_2) { create(:tag) }
    it 'shows the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show/:id' do
    let(:tag_1) { create(:tag) }
    it 'shows the page' do
      get :show, params: { id: tag_1.id }
      expect(response).to have_http_status(:success)
    end
  end
end
