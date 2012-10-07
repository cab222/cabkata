Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'PeS2cYkhHAn53KBCwceE3Q', 'A4JrkehH20eoalPIwWRl16dq2ZxeKcoXTTDZfKY8M'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end