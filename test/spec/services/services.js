(function() {
  'use strict';

  describe('Service: Menu', function() {
    var $httpBackend, Menu;
    beforeEach(module('portfolioNgApp'));
    Menu = {};
    $httpBackend = {};
    beforeEach(inject(function(_Menu_, $injector) {
      var uri;
      Menu = _Menu_;
      $httpBackend = $injector.get('$httpBackend');
      uri = 'http://localhost:8000/menu/list';
      return $httpBackend.whenGET(uri).respond({
        result: [1, 2, 3, 4, 5]
      });
    }));
    afterEach(function() {
      $httpBackend.verifyNoOutstandingExpectation();
      return $httpBackend.verifyNoOutstandingRequest();
    });
    return it('should return list', function() {
      var fubar;
      fubar = Menu.getList().get();
      $httpBackend.flush();
      expect(fubar.result.length).toEqual(5);
      return 1;
    });
  });

}).call(this);
