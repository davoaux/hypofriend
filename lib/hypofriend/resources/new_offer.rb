module Hypofriend
  class NewOffer
    @@resource = 'new-offers'

    attr_accessor :institution_name, :borrowing_rate

    def initialize(params = {})
      params = defaults.merge(params)

      @institution_name = params['institution_name']
      @borrowing_rate = params['borrowing_rate']
    end

    def self.resource
      @@resource
    end

    def self.get(params = {})
      query = Util::encode_parameters(params) unless params.empty?
      uri = Util::create_uri(@@resource, query)

      res = Net::HTTP.get_response(uri)

      case response
      when Net::HTTPSuccess then
        json = response.response_body_permitted? ? JSON.parse(response.body) : nil
      else
        raise "Unexpected response with code: #{response.code}"
      end

      NewOffer.new(json['data']['offers'][0]) unless json.nil?
    end

    private

    def defaults
      {
        'institution_name': '',
        'borrowing_rate': 0.0,
      }
    end
  end
end
