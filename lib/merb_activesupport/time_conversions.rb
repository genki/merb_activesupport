require( Merb::ActiveSupport::AS_CORE_EXT_DIR / :time / :conversions )
class Time
  include ActiveSupport::CoreExtensions::Time::Conversions
end
