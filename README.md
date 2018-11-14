# Strike-Ruby

This is a Ruby API Wrapper for the [Strike](https://strike.acinq.co/) bitcoin
payments API.

### Installing

System Gems:
```
gem install strike-ruby
```

or Gemfile:
```
gem 'strike-ruby'

```

## Usage

```
# /path/to/config.rb
Strike::Client.strike_api_env="test" || "live"
Strike::Client.strike_api_key="key from strike"
```
or
```
# use ENV['STRIKE_API_KEY'] and ENV['STRIKE_API_ENV']
Strike::Client.use_environment_variables
```

then use
```
# /some/sweet/lightning/app.rb

require "strike" # notice this is "strike" not "strike-ruby"

# List first 30 charges
Strike::Charge.all # identical to Strike::Charge.all(page: 1, per_page: 30)
# => [#<Strike::Charge:0x00007fb231184300 @id="ch_1jSMVtGiDptw8NQKB6GXTVYA1YJZZ", @amount=42000, @amount_satoshi=42000, @currency="btc", @description="1%20Blockaccino", @customer_id="This is a random test field", @payment_request="lntb520u1pd75atvpp5ntvt72p326r8mhyxeteujsu0p968zu3zfmf6zpvuva8nkr477qaqdqcxyjnyvzzd3hkx6mpvd3kjmn0cqp2qn9cl9hzjjzck6czwrskd0etnq5cjhsjndvlckzvp0hkt02vlhzjxr3raak4jcdkude3v4g8zr4g2ukzkqfjz7n4zvgsqz6qyk7rqxcpa2la7x", @paid=false, @created=1542092140171, @updated=1542092140171, @code=nil, @message=nil>...]

# List 50 results on page 2
Strike::Charge.all(page: 2, per_page: 50)
[...]

# Find by id
Strike::Charge.find("ch_1jSMVtGiDptw8NQKB6GXTVYA1YJZZ")
# => #<Strike::Charge:0x00007fb243344300 @id="ch_1jSMVtGiDptw8NQKB6GXTVYA1YJZZ", @amount=42000, @amount_satoshi=42000, @currency="btc", @description="1%20Blockaccino", @customer_id="This is a random test field", @payment_request="lntb520u1pd75atvpp5ntvt72p326r8mhyxeteujsu0p968zu3zfmf6zpvuva8nkr477qaqdqcxyjnyvzzd3hkx6mpvd3kjmn0cqp2qn9cl9hzjjzck6czwrskd0etnq5cjhsjndvlckzvp0hkt02vlhzjxr3raak4jcdkude3v4g8zr4g2ukzkqfjz7n4zvgsqz6qyk7rqxcpa2la7x", @paid=false, @created=1542092140171, @updated=1542092140171, @code=nil, @message=nil>

# Create charge
Strike::Charge.create(amount: 42_000, currency: "btc", description: "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks", customer_id: "optional text for tracking")
# => #<Strike::Charge:0x00007fea209216e0 @id="ch_3vymhqec4RZQVfKQtCKH5j3R6yv7u", @amount=42000, @amount_satoshi=42000, @currency="btc", @description="The Times 03/Jan/2009 Chancellor on brink of second bailout for banks", @customer_id="option text for identifying user", @payment_request="lntb420u1pd7hgr4pp5lt8hz548pnutq0z0zcxfsj2j9yu9kn4crzvnhwj5r4228thuzwvsdr0235x2gz5d9kk2ueqxqej7jnpdchnyvps8ysyx6rpde3k2mrvdaezqmmwyp38y6twdvsx7e3qwdjkxmmwvssxyctfd3hh2apqvehhygrzv9hxkuccqp2ev87r57en5smqqjaztv6x6hyddmg8q6e7j4at9prz4w0uz9auymy9ry3jjf7k75h40njgzd7gj5z3rspr9qaq3jhgtyzjfqfep5fracq43wt30", @paid=false, @created=1542168693183, @updated=1542168693183, @code=nil, @message=nil>

# Error!
Strike::Charge.find("foo")
# => #<Strike::Charge:0x00007ff7649cd368 @id=nil, @amount=nil, @amount_satoshi=nil, @currency=nil, @description=nil, @customer_id=nil, @payment_request=nil, @paid=nil, @created=nil, @updated=nil, @code=404, @message="not found">
```

## Built With

* [webmock](https://github.com/bblimke/webmock)
* [vcr](https://github.com/vcr/vcr)
* [faraday](https://github.com/lostisland/faraday)
* [json](https://github.com/flori/json)

## Contributing

Make a pull request or fork and go!

## Versioning

We use [SemVer](http://semver.org/) for versioning.

## Authors

* **Ted Price** - *Initial work* - [Stacksimple.io](https://github.com/stacksimple)

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
