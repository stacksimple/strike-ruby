require "test_helper"

class Strike::ChargeTest < Minitest::Test
  def options
    {
      amount: 42_000,
      currency: "btc",
      description: "1%20Blockaccino",
      customer_id: "This is a random test field"
    }
  end

  def setup
    Strike::Client.instance_variable_set :@conn, nil
    Strike::Client.strike_api_key = ENV["STRIKE_API_KEY"]
    Strike::Client.strike_api_env = "test"
  end

  def test_that_it_has_a_version_number
    refute_nil ::Strike::VERSION
  end

  def test_all
    VCR.use_cassette('charge/all') do
      Strike::Charge.create(options) # Create at least one
      refute_empty Strike::Charge.all
    end
  end

  def test_find
    VCR.use_cassette('charge/find') do
      id = Strike::Charge.all.first.id
      charge = Strike::Charge.find(id)
      refute_nil charge.id
      assert_equal id, charge.id
    end
  end

  def test_create
    VCR.use_cassette('charge/create') do
      charge = Strike::Charge.create(options)
      refute_nil charge.id
      assert_equal options[:amount], charge.amount
      assert_equal options[:currency], charge.currency
      assert_equal options[:description], charge.description
      assert_equal options[:customer_id], charge.customer_id
    end
  end

  def test_error_bad_parameters
    VCR.use_cassette('charge/error_bad_parameters') do
      assert_raises Strike::Errors::BadRequestError do
        Strike::Charge.create(options.merge(amount: "blah", currency: 123.45))
      end
    end
  end

  def test_error_invalid_api_key
    VCR.use_cassette('charge/error_invalid_api_key') do
      Strike::Client.instance_variable_set :@conn, nil
      Strike::Client.instance_variable_set :@api_url, nil
      key = Strike::Client.strike_api_key
      Strike::Client.strike_api_key = "foo"

      assert_raises Strike::Errors::UnauthorizedError do
        Strike::Charge.create(options)
      end
      Strike::Client.strike_api_key = key
    end
  end

  def test_error_resource_does_not_exist
    VCR.use_cassette('charge/error_resource_does_not_exist') do
      assert_raises Strike::Errors::NotFoundError do
        Strike::Charge.find(-1)
      end
    end
  end
end
