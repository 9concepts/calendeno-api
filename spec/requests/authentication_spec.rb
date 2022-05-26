require "rails_helper"

RSpec.describe "Authentication", type: :request do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "Google で認証" do
    it "Google のアカウント選択画面にリダイレクトされること" do
      get "/auth/google_oauth2"

      expect(response).to have_http_status(302)
    end

    it "新規ユーザーの認証後にユーザーが作成される" do
      expect {
        get "/auth/google_oauth2/callback"
      }.to change { User.count }.from(0).to(1)

      expect(response).to have_http_status(200)

      expect(User.first.email).to eq "john@example.com"
    end

    it "既存ユーザーの認証後にユーザーは作成されず、最新の情報で更新される" do
      create(:user, email: "john@example.com", name: "Old Name")

      expect {
        get "/auth/google_oauth2/callback"
      }.to_not change { User.count }

      expect(response).to have_http_status(200)

      user = User.first

      expect(user.email).to eq "john@example.com"
      expect(user.name).to eq "John Smith"
    end
  end
end
