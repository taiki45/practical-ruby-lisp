require File.expand_path('../../../eval.rb', __FILE__)

Given /^a clean RubyLisp/ do
  RubyLisp.reset!
end

When /^I pass/ do
  @expression = [:+, 2, 3]
end

Then /^I should see `([^`]*)`$/ do |expected|
  RubyLisp._eval(@expression, RubyLisp.env) == expected
end
