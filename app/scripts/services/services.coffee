'use strict';

angular.module('portfolioNgApp')
    .factory 'Menu', ['$resource', ($resource) ->
        @items = []
        keepGoing = true

        pushChild = (item, to = @items) =>
            angular.forEach to, (value) ->
                if keepGoing
                    if value.id is item.parent_id
                        keepGoing = false
                        value.children.push item
                        1
                    else
                        pushChild item, value.children
                        1
            1

        getItems = () =>
            console.log 'getItems'

            uri = 'http://localhost\\:8000/menu/list'
            $resource(
                uri,
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query (data) =>
                data.sort (a, b) ->
                    a.parent_id > b.parent_id

                angular.forEach data, (item) =>
                    item.children = []
                    if not item.parent_id
                        @items.push item
                    else
                        keepGoing = true
                        pushChild item
                    1

                1

        getItems()

        @getCards = (menuId) -> 
            $resource(
                'http://localhost\\:8000/get_cards/:menuId',
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query {menuId: menuId}
        
        @
    ]
