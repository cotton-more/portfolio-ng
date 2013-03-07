'use strict'

describe 'Service: Menu', () ->

  # load the service's module
  beforeEach module 'portfolioNgApp'

  # instantiate service
  Menu = {}
  $httpBackend = {}
  beforeEach inject (_Menu_, $injector) ->
    Menu = _Menu_
    $httpBackend = $injector.get '$httpBackend'
    uri = 'http://localhost:8000/menu/list'
    $httpBackend.whenGET(uri).respond { result: [1..5] }

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'should return list', () ->
    fubar = Menu.getList().get()
    $httpBackend.flush()
    expect(fubar.result.length).toEqual(5)
    1
