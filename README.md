# SendGridWebApi

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'send_grid_web_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install send_grid_web_api

## Usage

   ```
   client = SendGridWebApi::Client.new("username", "password")
   ```
   Get bounced emails:
   ```
   bounced_email = client.bounce.get

   bounced_email.each { |e| puts e['email'] }
   bounced_email.each { |e| client.bounce.delete({email: e["email"]}) }
   ```

   Get the last 5 days of blocked emails:

   ```
   client.block.get({ days:5 })
   ```

## Contributing

1. Fork it ( https://github.com/cshirley/send_grid_web_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
