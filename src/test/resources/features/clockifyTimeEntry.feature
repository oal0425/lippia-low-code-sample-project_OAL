@TimeEntry @all
Feature: TimeEntry operations

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header X-Api-Key = ZmNhMGM5YzQtOGE2Ny00ZDhkLWEwMDYtNGYyMmU2NGI4NjIw
    Given base url https://api.clockify.me/api

  @ListWorkspaces
  Scenario: Get all my workspaces
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[1].id

  @ListUsers
  Scenario: Find all users on workspace
    Given call clockifyTimeEntry.feature@ListWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/users
    And execute method GET
    Then the status code should be 200
    * define idUser = $.[0].id


    @ListTimeEntries
    Scenario: Get time entries for a user on workspace
      Given call clockifyTimeEntry.feature@ListWorkspaces
      And call clockifyTimeEntry.feature@ListUsers
      And endpoint /v1/workspaces/{{idWorkspace}}/user/{{idUser}}/time-entries
      And execute method GET
      Then the status code should be 200
      * define idTimeEntry = $.[0].id

    @TimeEntry1 #verificar el proyecto al cual se le estan agregando horas
    Scenario: Add a new time entry
      Given call clockifyTimeEntry.feature@ListWorkspaces
      And endpoint /v1/workspaces/{{idWorkspace}}/time-entries
      And body newTimeEntry.json
      When execute method POST
      Then the status code should be 201


    @TimeEntry2 #verificar el proyecto al cual se le estan realizando modificaciones
    Scenario: Update time entry on workspace
      Given call clockifyTimeEntry.feature@ListWorkspaces
      And call clockifyTimeEntry.feature@ListTimeEntries
      And endpoint /v1/workspaces/{{idWorkspace}}/time-entries/{{idTimeEntry}}
      And body updateTimeEntry.json
      When execute method PUT
      Then the status code should be 200


    @TimeEntry3 #agregar contenido a la time entry
    Scenario: Delete time entry from workspace
      Given call clockifyTimeEntry.feature@ListWorkspaces
      And call clockifyTimeEntry.feature@ListTimeEntries
      And endpoint /v1/workspaces/{{idWorkspace}}/time-entries/{{idTimeEntry}}
      When execute method DELETE
      Then the status code should be 204
