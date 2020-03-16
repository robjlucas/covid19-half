# FactoryBot is used in Rails' mailer previews (http://localhost/rails/mailers).
# But it conflicts with class reloading as it holds on to previous definitions,
# causing ActiveRecord to raise TypeMismatch errors.
# To fix this set the `FIX_MAILER_PREVIEWS` env var when starting the server, which
# will activate this initializer that resets the factories before each request.
# It's behind a env flag because it's rather expensive to do this all the time.
if ENV["FIX_MAILER_PREVIEWS"] && Rails.configuration.cache_classes == false
  Rails.application.config.to_prepare do
    FactoryBot.reload if FactoryBot.factories.any?
  end
end
