@Clients @all
  Feature: Clients


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

      @ListClients
      Scenario: get all the clients from a workspace
        Given call clockifyProjects.feature@ListWorkspaces
        And base url https://api.clockify.me/api
        And endpoint /v1/workspaces/{{idWorkspace}}/clients
        When execute method GET
        Then the status code should be 200
        * define idCliente = $.[0].id

    @Client1
    Scenario: Add a new client to a workspace
      Given call clockifyCliente.feature@ListWorkspaces
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/clients
      And body agregarCliente.json
      When execute method POST
      Then the status code should be 201

    @Client2
    Scenario: Add a new client to a workspace
      Given call clockifyCliente.feature@ListWorkspaces
      And call clockifyCliente.feature@ListClients
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/clients/{{idCliente}}
      When execute method DELETE
      Then the status code should be 200


