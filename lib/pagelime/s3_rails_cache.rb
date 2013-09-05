module Pagelime
  class S3RailsCache < S3Client
    module ClassMethods
      def generate_cache_key(page_path, format = default_format)
        "pagelime:cms:#{format}:page:#{Base64.encode64(page_path)}"
      end
      
      def shared_cache_key(format = default_format)
        "pagelime:cms:#{format}:shared"
      end
    end
    
    extend ClassMethods
    
    def fetch(page_path, format = self.class.default_format)
      cache_key = self.class.generate_cache_key(page_path, format)
      
      value = ::Rails.cache.fetch(cache_key, :expires_in => 1.year) do
        Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: NO '#{page_path}' CACHE... loading #{format}"
        super
      end
      
      Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: fetch (#{page_path}) value: #{value.inspect}"
      
      value
    end
    
    def fetch_shared(format = self.class.default_format)
      cache_key = self.class.shared_cache_key(format)
      
      value = ::Rails.cache.fetch(cache_key, :expires_in => 1.year) do
        Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: NO SHARED CACHE... loading #{format}"
        super
      end
      
      Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: fetch_shared value: #{value.inspect}"
      
      value
    end
    
    def clear(page_path, format = self.class.default_format)
      cache_key = self.class.generate_cache_key(page_path, format)
      
      ::Rails.cache.delete cache_key
    end
    
    def clear_shared(format = self.class.default_format)
      cache_key = self.class.shared_cache_key(format)
      
      ::Rails.cache.delete cache_key
    end
  end
end
