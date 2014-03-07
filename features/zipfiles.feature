Feature: CSV Validation
  
  Scenario: Upload multiple zipped CSVs for validation
    When I go to the homepage
    And I attach the file "csvs/multiple_files.zip" to the "file" field
    And I press "Validate"
    Then I should be redirected to my package page
    And I should see "valid.csv"
    And I should see "warnings.csv"
    And I should see "revalidate.csv"
    And my datapackage should be persisited in the database
    
  Scenario: Upload a single zipped CSV for validation
    When I go to the homepage
    And I attach the file "csvs/valid.zip" to the "file" field
    And I press "Validate"
    Then I should see a page of validation results
    And "valid.csv" should be persisted in the database
    And my file should be saved in the database
  
  
  