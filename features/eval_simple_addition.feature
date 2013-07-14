Feature: RubyScheme evals simple addition expression

  In order to get calculated result
  As wathcer
  I want RubyScheme to calculate 2 + 3

  Scenario: eval simple addition
    Given a clean RubyScheme
    When I pass [:+, 2, 3]
    Then I should see `5`
