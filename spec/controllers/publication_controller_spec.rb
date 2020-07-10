require 'rails_helper'

describe PublicationsController do
  describe 'GET map' do
    let(:publication_1) { create(:publication) }
    let(:publication_2) { create(:publication) }
    it 'shows the page' do
      get :map
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET list of publications' do
    let(:publication_1) { create(:publication) }
    let(:publication_2) { create(:publication) }
    it 'shows the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show/:id' do
    let(:publication_1) { create(:publication) }
    it 'shows the page' do
      get :show, params: { id: publication_1.id }
      expect(response).to have_http_status(:success)
    end
  end
end
