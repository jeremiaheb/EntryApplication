#ActionView::Helpers::UrlHelper.module_eval do
  #if Rails.env.production?
    #def url_for(options = nil)
      #results = super(options)
      #results.insert(0, "/RVC_Data_Entry") unless results.match /^\/RVC_Data_Entry/
        #results
    #end
  #end
#end

ActionView::RoutingUrlFor.module_eval do
  if Rails.env.production?
    def url_for(options = nil)
      results = super(options)
      results.insert(0, "/RVC_Data_Entry") unless results.match /^\/RVC_Data_Entry/
        results
    end
  end
end

