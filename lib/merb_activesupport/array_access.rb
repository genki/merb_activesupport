require( Merb::ActiveSupport::AS_CORE_EXT_DIR / :array / :access )
class Array
  include ActiveSupport::CoreExtensions::Array::Access
end
