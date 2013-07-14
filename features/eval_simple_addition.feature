Feature: RubyLisp evals simple addition expression

  In order to get calculated result
  As wathcer
  I want RubyLisp to calculate 2 + 3

  Scenario: eval simple addition
    Given a clean RubyLisp
    When I pass [:+, 2, 3]
    Then I should see `5`
