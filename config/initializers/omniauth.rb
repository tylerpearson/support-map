Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "355359997924701", "78f3afeb4cedf5880b0a6e26ffbcc827",
    :display => "page",
    :scope => "email,user_about_me,user_location,friends_location"
end