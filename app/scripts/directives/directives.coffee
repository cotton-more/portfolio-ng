'use strict'

angular.module('portfolioNgApp')
    .directive 'niMenu', [()->
        console.log 'niMenu', @
        niMenu = 
            template: """
                <ul>
                    <ni-menu-item ng-repeat="item in tree"></ni-menu-item>
                </ul>
            """
            replace: true
            transclude: true
            restrict: 'E'
            scope:
                tree: '=ngModel'
    ]

angular.module('portfolioNgApp')
    .directive 'niMenuItem', ['$compile', ($compile) ->
        niMenuItem =
            restrict: 'E'
            template: """
                <li>
                    <span>{{item.name}}</span>
                </li>
            """
            link: (scope, elm, attrs) ->
                if scope.item.children.length
                    childItem = $compile('<ni-menu ng-model="item.children"></ni-menu>')(scope)
                    elm.append childItem
                1
    ]
