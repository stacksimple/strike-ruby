require "test_helper"

class Strike::ClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Strike::VERSION
  end

  def test_live_api_url
    Strike::Client.strike_api_env = "live"
    refute_match /\.dev\./, Strike::Client.api_url
  end

  def test_test_api_url
    Strike::Client.strike_api_env = "not live"
    assert_match /\.dev\./, Strike::Client.api_url
  end
end
