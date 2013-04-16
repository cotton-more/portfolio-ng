'use strict'

MenuCtrl = ($scope, Menu) ->
    $scope.tree = Menu.items
    1

MenuCtrl.$inject = ['$scope', 'Menu']
angular.module('portfolioNgApp').controller 'MenuCtrl', MenuCtrl

CardListCtrl = ($scope, $routeParams, Menu) ->
    $scope.cards = Menu.getCards($routeParams.menuId)
    1

CardListCtrl.$inject = ['$scope', '$routeParams', 'Menu']
angular.module('portfolioNgApp').controller 'CardListCtrl', CardListCtrl
