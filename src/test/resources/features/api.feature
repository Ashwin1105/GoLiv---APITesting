Feature: Generic schema-driven API coverage
  Derived from the uploaded OpenAPI spec's own declared constraints — no AI.

  Scenario: TC_API_001 - valid request returns a successful response
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be below 300

  Scenario: TC_API_002 - missing required field "planType" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_003 - "planType" outside the declared enum is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"__INVALID_ENUM_VALUE__","entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_004 - missing required field "entryAge" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_005 - "entryAge" below the declared minimum (18) is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":17,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_006 - "entryAge" above the declared maximum (65) is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":66,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_007 - missing required field "policyTerm" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_008 - "policyTerm" below the declared minimum (5) is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":4,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_009 - "policyTerm" above the declared maximum (40) is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":41,"sumAssured":2500000,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_010 - missing required field "sumAssured" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_011 - "sumAssured" below the declared minimum (2500000) is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2499999,"gender":"male","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_012 - missing required field "gender" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2500000,"smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_013 - "gender" outside the declared enum is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"__INVALID_ENUM_VALUE__","smoker":true}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_014 - missing required field "smoker" is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"male"}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_015 - "smoker" outside the declared enum is rejected
    When I send a POST request to "/api/premium/calculate" with body:
      """
      {"planType":"Regular Pay","entryAge":42,"policyTerm":23,"sumAssured":2500000,"gender":"male","smoker":"__INVALID_ENUM_VALUE__"}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_016 - valid request returns a successful response
    When I send a POST request to "/api/claims/acknowledge" with body:
      """
      {"policyNo":"test-value","claimType":"test-value"}
      """
    Then the response status should be below 300

  Scenario: TC_API_017 - missing required field "policyNo" is rejected
    When I send a POST request to "/api/claims/acknowledge" with body:
      """
      {"claimType":"test-value"}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_018 - missing required field "claimType" is rejected
    When I send a POST request to "/api/claims/acknowledge" with body:
      """
      {"policyNo":"test-value"}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_019 - valid request returns a successful response
    When I send a POST request to "/api/policy/paidup" with body:
      """
      {"planType":"test-value","premsPaid":1,"totalPrems":1,"sumAssured":1}
      """
    Then the response status should be below 300

  Scenario: TC_API_020 - missing required field "planType" is rejected
    When I send a POST request to "/api/policy/paidup" with body:
      """
      {"premsPaid":1,"totalPrems":1,"sumAssured":1}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_021 - missing required field "premsPaid" is rejected
    When I send a POST request to "/api/policy/paidup" with body:
      """
      {"planType":"test-value","totalPrems":1,"sumAssured":1}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_022 - missing required field "totalPrems" is rejected
    When I send a POST request to "/api/policy/paidup" with body:
      """
      {"planType":"test-value","premsPaid":1,"sumAssured":1}
      """
    Then the response status should be at least 400 and below 500

  Scenario: TC_API_023 - missing required field "sumAssured" is rejected
    When I send a POST request to "/api/policy/paidup" with body:
      """
      {"planType":"test-value","premsPaid":1,"totalPrems":1}
      """
    Then the response status should be at least 400 and below 500
