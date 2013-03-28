'use strict'

MenuCtrl = ($scope, Menu) ->
    $scope.tree = Menu.items
    1

MenuCtrl.$inject = ['$scope', 'Menu']
angular.module('portfolioNgApp').controller 'MenuCtrl', MenuCtrl

CardCtrl = ($scope) ->
    console.log 'test'
    1

CardCtrl.$inject = ['$scope']
angular.module('portfolioNgApp').controller 'CardCtrl', CardCtrl
