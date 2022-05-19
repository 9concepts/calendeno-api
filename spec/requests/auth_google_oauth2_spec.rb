require "rails_helper"

RSpec.describe 'root', type: :request do
  describe 'GET /auth/google_oauth2' do
    it 'Google のアカウント選択画面にリダイレクトされること' do
      get '/auth/google_oauth2'

      expect(response).to have_http_status(302)
    end
  end
end
