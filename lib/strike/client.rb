require 'faraday'
require 'json'

module Strike

  class Client
    # Set live url, default anything else to test
    API_URLS = {
      live: "https://api.strike.acinq.co".freeze
    }.tap { |hsh| hsh.default = "https://api.dev.strike.acinq.co".freeze }
    .freeze

    class << self
      attr_accessor :strike_api_env, :strike_api_key

      def use_environment_variables
        self.strike_api_key = ENV['STRIKE_API_KEY']
        self.strike_api_env = ENV['STRIKE_API_ENV'].downcase
      end

      def conn
        return @conn if @conn

        raise "Please set strike_api_key" if (strike_api_key || "").empty?

        @conn = Faraday.new(url: api_url) do |builder|
          builder.use Faraday::Request::BasicAuthentication, strike_api_key, nil
          builder.use Faraday::Adapter::NetHttp
        end
      end

      def api_url
        API_URLS[strike_api_env.to_sym]
      end
    end
  end
end
