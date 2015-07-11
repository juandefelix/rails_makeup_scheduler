Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = Proc.new do |env|
    OmniauthCallbacksController.action(:failure).call(env)
  end
end