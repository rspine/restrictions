# Spine::Restrictions

[![Gem Version](https://badge.fury.io/rb/spine-restrictions.svg)](http://badge.fury.io/rb/spine-restrictions)
[![Dependency Status](https://gemnasium.com/rspine/restrictions.svg)](https://gemnasium.com/rspine/restrictions)
[![Test Coverage](https://codeclimate.com/github/rspine/restrictions/badges/coverage.svg)](https://codeclimate.com/github/rspine/restrictions/coverage)
[![Code Climate](https://codeclimate.com/github/rspine/restrictions/badges/gpa.svg)](https://codeclimate.com/github/rspine/restrictions)

Restrictions registration for application context.

## Installation

To install it, add the gem to your Gemfile:

```ruby
gem 'spine-restrictions'
```

Then run `bundle`. If you're not using Bundler, just `gem install spine-restrictions`.

## Usage

```ruby
# Restriction can be module or class, which defines `restricted?` method based
# on context.
class UserSuspensionRestriction
  def restricted?(context)
    !!context.subject.suspended_at
  end
end

restrictions = Spine::Restrictions::Collection.new
restrictions.register(UserSuspensionRestriction)
  .restrict(:write, :all)
  .restrict(:update, :all)
  .restrict(:delete, :all)
  .except(:all, :billing)

restrictions.restricted?(context, :write, :tasks)
# => <UserSuspensionRestriction:0x007f8e51ad7960>
```
