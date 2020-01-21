class ApiRateLimiter
  attr_accessor :user, :controller_path, :action_name

  def initialize(options = {})
    self.user = options[:user]
    self.controller_path = options[:controller_path]
    self.action_name = options[:action_name]
  end

  def limit_exhausted?
    if calls_limit_per_hour >= (cached_limit + 1)
      update_cached_limit
      false
    else
      true
    end
  end

  private

  def cache_key
    "api-calls-#{user.id}-#{controller_path}-#{action_name}"
  end

  def cached_limit
    redis.get(cache_key).to_i
  end

  def update_cached_limit
    if cached_limit.zero?
      redis.set(cache_key, cached_limit + 1)
      redis.expire(cache_key, 3600)
    else
      redis.incr(cache_key)
    end
    ApiCall.create(user: user)
  end

  def calls_limit_per_hour
    # ToDo - Cache subscriptions limit
    user.subscriptions.active.sum(:calls_limit_per_hour)
  end

  def redis
    $redis
  end
end