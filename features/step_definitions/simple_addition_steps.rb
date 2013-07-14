require File.expand_path('../../../eval.rb', __FILE__)

Given /^a clean RubyScheme/ do
  RubyScheme.reset!
end

When /^I pass/ do
  @expression = [:+, 2, 3]
end

Then /^I should see `([^`]*)`$/ do |expected|
  RubyScheme._eval(@expression, RubyScheme.env) == expected
end
