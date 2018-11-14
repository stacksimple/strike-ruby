require 'faraday'
require 'json'

module Strike
  class Charge
    PATH = "/api/v1/charges".freeze

    def self.api_url
      @api_url ||= PATH
    end

    def self.conn
      Client.conn
    end

    attr_accessor :id,  # String Unique identifier of the charge
      :amount,          # Integer Positive integer in the smallest unit in the currency used.  If the currency is btc, the amount must be in satoshi.
      :amount_satoshi,  # Integer Amount in satoshi.
      :currency, #String Currency code associated with the amount. Only btc is supported currently.
      :description, #String Discretionary description of the charge.
      :customer_id, #String Optional field, can be used to attach an identifier of your choice to the charge.
      :payment_request, #String Lightning payment request corresponding to the charge.  This needs to be sent to the user.
      :paid, #Boolean Indicates whether the charge has been paid or not.
      :created, #Integer Time at which the charge was created.
      :updated, #String Time at which the charge was last updated.
      :code,
      :message

    attr_reader :error

    def initialize(options)
      self.id = options["id"]
      self.amount = options["amount"]
      self.amount_satoshi = options["amount_satoshi"]
      self.currency = options["currency"]
      self.description = options["description"]
      self.customer_id = options["customer_id"]
      self.payment_request = options["payment_request"]
      self.paid = options["paid"]
      self.created = options["created"]
      self.updated = options["updated"]
      self.code = options["code"]
      self.message = options["message"]
    end

    def success?
      code.nil? || code == 200
    end

    def fail?
      !success?
    end

    # Fetch a charge by id
    #
    # @param page [Integer] page of results to display
    # @param per_page [Integer] number of results per page
    #
    # returns [Strike::Charge]
    def self.all(page: 1, per_page: 30)
      response =
        conn.get do |req|
          req.url api_url
          req.params['page'] = (page - 1).to_i
          req.params['size'] = per_page.to_i
        end
      handle_errors(response)

      JSON.parse(response.body).map { |attributes| new(attributes) }
    end

    # Fetch a charge by id
    #
    # @param id [String] ID of Strike charge record
    #
    # returns [Strike::Charge]
    def self.find(id)
      response = conn.get("#{api_url}/#{id}")
      handle_errors(response)

      new(JSON.parse(response.body))
    end

    # Create a new Strike charge
    #
    # @param amount [Integer]  Positive integer in the smallest unit in the currency used. If the currency is btc, the amount must be in satoshi, and the maximum amount is 4,294,967 satoshis.
    # @param currency [String] Currency code associated with the amount.  Only btc is supported currently.
    # @param description [String] Discretionary description of the charge. Must not exceed 256 characters.
    # @param customer_id [String] This field is optional and can be used to attach an identifier of your choice to the charge. Must not exceed 64 characters.
    #
    # returns [Strike::Charge]
    def self.create(amount:, currency:, description:, customer_id:)
      body = {
        amount: amount,
        currency: currency,
        description: description,
        customer_id: customer_id
      }

      response =
        conn.post do |req|
          req.url api_url
          req.headers['Content-Type'] = 'application/json'
          req.body = body.to_json
        end

      handle_errors(response)

      new(JSON.parse(response.body))
    end

    def self.handle_errors(response)
      error = Strike::Errors::ERROR_MAP[response.status]
      raise error.new if error
    end
  end
end
