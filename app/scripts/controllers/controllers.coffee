'use strict'

# Menu contraller
MenuCtrl = ($scope, Menu) ->
    $scope.tree = Menu.getTree()

MenuCtrl.$inject = ['$scope', 'Menu']
angular.module('portfolioNgApp').controller 'MenuCtrl', MenuCtrl


# Edit menu controller
MenuEditCtrl = ($scope, $route, Menu) ->
    #menuId = $route.current.params.menuId
    #$scope.menu = Menu.getMenu()

    #$scope.save = ->
        #Menu.updateItem($scope.menu)

MenuEditCtrl.$inject = ['$scope', '$route', 'Menu']
angular.module('portfolioNgApp').controller 'MenuEditCtrl', MenuEditCtrl

# List menu's cards
CardListCtrl = ($scope, $rootScope, $routeParams, Menu) ->
    menuId = parseInt $routeParams.menuId, 10

    $scope.menu = Menu.currentMenu

    $scope.cards = Menu.getCards menuId

    Menu.onMenuLoaded $scope, (menu) ->
        angular.forEach menu, (item) ->
            if item.id is menuId
                $scope.menu = item

CardListCtrl.$inject = ['$scope', '$rootScope', '$routeParams', 'Menu']
angular.module('portfolioNgApp').controller 'CardListCtrl', CardListCtrl
