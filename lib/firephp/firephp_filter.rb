module ActionController
  class Base
    
   private
    def firephp(_obj, _type="LOG")
      @firephp||={}
      _type.upcase!
      _type="LOG" if !(_type=~/^(INFO|WARN|ERROR)$/)
      @firephp[_type]||=[]
      @firephp[_type]<<_obj
    end
    
    def firephp_params
      @firephp["params"]=true
    end

    def firephp_headers
      @firephp["headers"]=true
    end

    def firephp_filter
      #-Add headers only when browser has FirePHP-Plugin
      return if !(request.headers["HTTP_USER_AGENT"]=~/FirePHP\//)
      return if @firephp.blank?
      
      headers["X-FirePHP-Data-100000000001"]='{'
      headers["X-FirePHP-Data-200000000001"]='"FirePHP.Dump":{'
      headers["X-FirePHP-Data-200000000002"]="\"RailsVersion\":\"#{RAILS_GEM_VERSION}\","
      headers["X-FirePHP-Data-299999999999"]='"__SKIP__":"__SKIP__"},'
      headers["X-FirePHP-Data-300000000001"]='"FirePHP.Firebug.Console":['
      count=2
      @firephp.each do |type, arr|
        next if !(type=~/^(LOG|INFO|WARN|ERROR)$/)
        arr.each do |a|
          headers["X-FirePHP-Data-3#{sprintf("%011d", count)}"]="[\"#{type}\",#{a.to_json}],"
          count+=1
        end
      end
      #headers["X-FirePHP-Data-3#{sprintf("%011d", count)}"]="[\"INFO\",#{["RailsFirebug",@firephp].to_json}],"
      #count+=1
      if !@firephp["params"].blank?
        headers["X-FirePHP-Data-3#{sprintf("%011d", count)}"]="[\"INFO\",#{["RailsParams",params].to_json}],"
        count+=1
      end
      if !@firephp["headers"].blank?
        headers["X-FirePHP-Data-3#{sprintf("%011d", count)}"]="[\"INFO\",#{["RailsHeaders",request.headers].to_json}],"
        count+=1
      end
      headers["X-FirePHP-Data-399999999999"]='["__SKIP__"]],'
      headers["X-FirePHP-Data-999999999999"]='"__SKIP__":"__SKIP__"}'
    end
    
  end
end