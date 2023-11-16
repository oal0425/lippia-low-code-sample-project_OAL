@Projects @all
Feature: Projects

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header X-Api-Key = ZmNhMGM5YzQtOGE2Ny00ZDhkLWEwMDYtNGYyMmU2NGI4NjIw

  @ListWorkspaces
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @ListProjects
  Scenario: get all projects from a workspace
    Given call clockifyProjects.feature@ListWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idProject = $.[0].id



  @Project2
  Scenario: get a project by id
    Given call clockifyProjects.feature@ListWorkspaces
    And call clockifyProjects.feature@ListProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 200

  @Project3
  Scenario: create a project in a workspace
    Given call clockifyProjects.feature@ListWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And body agregarProject.json
    When execute method POST
    Then the status code should be 201

  @Project4
  Scenario: modify a project attribute
    Given call clockifyProjects.feature@ListWorkspaces
    And call clockifyProjects.feature@ListProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And body updateProject.json
    When execute method PUT
    Then the status code should be 200

  @Project5
  Scenario: Camino NoFeliz Add a project that already exists
    Given call clockifyProjects.feature@ListWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And body agregarProject.json
    When execute method POST
    Then the status code should be 400

  @Project6
  Scenario: Camino NoFeliz Add Project without valid Api Key
    And header X-Api-Key = ZmNhMGM5YzQtOGE2Ny00ZDhkLWEwMDYtNGYy151515U2NGI4N
    Given call clockifyProjects.feature@ListWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And body agregarProject.json
    When execute method POST
    Then the status code should be 401

  @Project7
  Scenario: Camino NoFeliz Add Project without valid endpoint
    Given call clockifyProjects.feature@ListWorkspaces
    And base url https://api.clockify.me/api
    And endpoint /v2/workspaces/{{idWorkspace}}
    And body agregarProject.json
    When execute method POST
    Then the status code should be 404

  @Project8
    Scenario Outline: Editar el valor de algún campo del proyecto y validar el cambio realizado
    Given call clockifyProjects.feature@ListWorkspaces
    And call clockifyProjects.feature@ListProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And set value <values> of key archived,billable in body updateProject.json
    When execute method PUT
    Then the status code should be 200
    Examples:
      | values         |  |
      | "true", "true" |  |
