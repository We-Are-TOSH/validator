Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['ALLOWED_ORIGINS']
    resource '/api/*',
             headers: :any,
             methods: %i[post options]
  end
end
