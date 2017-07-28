# FV::Unified

The FV::Unified gem is a ruby client for the Unified Login API that provides
ActiveRecord-like syntax.

### Usage

**Configuration**
```ruby
FV::Unified.configure do |config|
  config.client_id = 'revelation'
  config.client_secret = 'super-secret-thing'
end
```

**Resource querying**
```
FV::Unified::User.all # [FV::Unified::User, FV::Unified::User, ...]
FV::Unified::User.find(123) # FV::Unified::User
FV::Unified::User.where(email: 'godzilla@rawr.com') # [FV::Unified::User]
```

**Resource attributes**
```ruby
user = FV::Unified::User.find(123)
user.first_name # 'Bob'
user.last_name # 'Johnson'
```
