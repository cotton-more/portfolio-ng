'use strict'

PortfolioCtrl = ($scope, Menu) ->
    #$scope.tree = Menu.items
    $scope.tree = [
        {name: 'test', children: []}
        {name: 'foo', children: []}
    ]

    console.log $scope.tree
    1

PortfolioCtrl.$inject = ['$scope', 'Menu']
angular.module('portfolioNgApp').controller 'PortfolioCtrl', PortfolioCtrl
