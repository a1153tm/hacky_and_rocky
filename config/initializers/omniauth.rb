Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production? and !ENV['TEST']
  then provider :facebook, "651646748202839", "3bcefe12c7ba6d497c834178b25da5d9"
  else provider :developer
  end
end

