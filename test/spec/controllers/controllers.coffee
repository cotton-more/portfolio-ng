'use strict'

describe 'Controller: PortfolioCtrl', () ->

  # load the controller's module
  beforeEach module 'portfolioNgApp'

  PortfolioCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    scope = {}
    PortfolioCtrl = $controller 'PortfolioCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
