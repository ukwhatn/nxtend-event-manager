secure = Rails.env.production?
key = Rails.env.production? ? "_app_session" : "_app_session_#{Rails.env}"
domain = ENV.fetch("APP_HOST", "localhost")

NxtendEventManager::Application.config.session_store :redis_store,
                                                servers: ["redis://redis:6379/0/session"],
                                                expire_after: 4.days,
                                                key:,
                                                domain:,
                                                threadsafe: true,
                                                secure:,
                                                httponly: true
