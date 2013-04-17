'use strict';

angular.module('portfolioNgApp')
    .factory 'Menu', ['$resource', ($resource) ->
        menuId = 0
        tree = []
        menu_ = []
        keepGoing = true

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

        getTree = () =>
            retrun tree if tree.length

            uri = 'http://localhost\\:8000/menu/list'
            $resource(
                uri,
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query (data) =>
                angular.forEach data, (item) =>
                    menu_.push item
                    item.children = []
                    keepGoing = true
                    pushChild item

            tree

        getCards = () ->
            $resource(
                'http://localhost\\:8000/get_cards/:menuId',
                {callback: 'JSON_CALLBACK'},
                query: {method: 'JSONP', isArray: true}
            ).query {menuId: menuId}

        getMenu = (callback) ->
            $resource(
                'http://localhost\\:8000/menu/:menuId',
                {callback: 'JSON_CALLBACK'},
                get: {method: 'JSONP'}
            ).get {menuId: menuId}

        updateItem = (item)->
            menu_[0]['name'] = Math.random()
            tree[1]['name'] = Math.random()
            console.log tree, menu_

        getTree: getTree
        getCards: getCards
        getMenu: getMenu
        updateItem: updateItem
        setMenuId: (id) ->
            menuId = id
    ]
