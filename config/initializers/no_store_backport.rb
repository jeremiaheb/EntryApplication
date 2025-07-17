# Backport no_store method from more recent versions of Rails
module ActionController::ConditionalGet
  unless method_defined?(:no_store)
    define_method(:no_store) do
      response.cache_control.replace(no_cache: true, extras: ["no-store"])
    end
  end
end
