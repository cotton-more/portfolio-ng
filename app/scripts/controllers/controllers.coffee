'use strict'

# Menu contraller
MenuCtrl = ($scope, Menu) ->
    $scope.tree = Menu.getTree()

MenuCtrl.$inject = ['$scope', 'Menu']
angular.module('portfolioNgApp').controller 'MenuCtrl', MenuCtrl


# Edit menu controller
MenuEditCtrl = ($scope, $route, Menu) ->
    menuId = $route.current.params.menuId
    Menu.setMenuId $route.current.params.menuId
    $scope.menu = Menu.getMenu()

    $scope.save = ->
        Menu.updateItem($scope.menu)

MenuEditCtrl.$inject = ['$scope', '$route', 'Menu']
angular.module('portfolioNgApp').controller 'MenuEditCtrl', MenuEditCtrl

# List menu's cards
CardListCtrl = ($scope, $routeParams, Menu) ->
    Menu.setMenuId $routeParams.menuId
    $scope.menu = Menu.getMenu()
    $scope.cards = Menu.getCards()

CardListCtrl.$inject = ['$scope', '$routeParams', 'Menu']
angular.module('portfolioNgApp').controller 'CardListCtrl', CardListCtrl
