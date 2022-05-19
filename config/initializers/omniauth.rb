Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Settings.auth.google.client_id,
    Settings.auth.google.client_secret
end
OmniAuth.config.allowed_request_methods = %i[get]
