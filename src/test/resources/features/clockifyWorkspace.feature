@Workspace @all
  Feature: Workspace Creation

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header X-Api-Key = ZmNhMGM5YzQtOGE2Ny00ZDhkLWEwMDYtNGYyMmU2NGI4NjIw

  @Workspace1
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200


  @Workspace2
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    And validar schema allworkspaces.json
    And defino una variable con nombre <idWorspace> que contenga el id de workspace cuyo nombre es <newWorkspace>


  @Workspace3
  Scenario: Create Workspace
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And body agregarWorkspace.json
    When execute method POST
    Then the status code should be 201

