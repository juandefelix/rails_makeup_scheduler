Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:failure).call(env)
    #this will invoke the failure action in SessionsController.
  end
end