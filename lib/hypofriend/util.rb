module Hypofriend
  module Util
    def self.create_uri(resource, query = nil)
      uri_string = "#{Hypofriend::BASE_URL}/#{resource}"
      uri_string << "?#{query}" unless query.nil?

      URI(uri_string)
    end

    def self.encode_parameters(params)
      if params.is_a? Enumerable
        return params.map{ |k, v| "#{k}=#{v}" }.join('&')
      end
      raise 'Argument should be an Enumerable'
    end
  end
end
