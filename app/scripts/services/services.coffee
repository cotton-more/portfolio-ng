'use strict';

angular.module('portfolioNgApp')
    .factory 'Menu', ['$resource', '$rootScope', ($resource, $rootScope) ->
        keepGoing = true
        tree = []
        menu = []

        MenuService =
            currentMenu: false

        TREE_LOADED = 'treeLoaded'
        CARDS_LOADED = 'cardsLoaded'

        pushChild = (item, to = tree) ->
            if item.parent_id is null
                to.push item
            else
                angular.forEach to, (value) ->
                    if keepGoing
                        if value.id is item.parent_id
                            keepGoing = false
                            value.children.push item
                        else
                            pushChild item, value.children

        MenuService.getTree = () =>
            return tree if tree.length

            uri = 'http://localhost\\:8000/menu/list'
            $resource(
                uri,
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query (data) =>
                menu = data
                angular.forEach data, (item) =>
                    item.children = []
                    keepGoing = true
                    pushChild item
                $rootScope.$broadcast(TREE_LOADED, menu);
            tree

        MenuService.onMenuLoaded = ($scope, handle) ->
            $scope.$on TREE_LOADED, (event, message) ->
                handle message

        MenuService.onCardsLoaded = ($scope, handle) ->
            $scope.$on CARDS_LOADED, (event, message) ->
                handle message

        MenuService.getCards = (menuId, callback) ->
            if not angular.isFunction callback
                callback = angular.noop

            $resource(
                'http://localhost\\:8000/get_cards/:menuId',
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query {menuId: menuId}, callback

        MenuService
    ]
