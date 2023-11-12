Rails.application.config.session_store :redis_session_store,
  key: 'projectdb_session',
  redis: {
    expire_after: 60.minutes,  # cookie expiration
    key_prefix: 'projectdb:session:',
    url: ENV['PROJECTDB_REDIS_URL'],
  }
