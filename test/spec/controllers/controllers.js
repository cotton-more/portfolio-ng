(function() {
  'use strict';

  describe('Controller: PortfolioCtrl', function() {
    var PortfolioCtrl, scope;
    beforeEach(module('portfolioNgApp'));
    PortfolioCtrl = {};
    scope = {};
    beforeEach(inject(function($controller) {
      scope = {};
      return PortfolioCtrl = $controller('PortfolioCtrl', {
        $scope: scope
      });
    }));
    return it('should attach a list of awesomeThings to the scope', function() {
      return expect(scope.awesomeThings.length).toBe(3);
    });
  });

}).call(this);
