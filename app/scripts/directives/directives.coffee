'use strict'

angular.module('portfolioNgApp')
    .directive 'niMenu', [()->
        console.log 'niMenu', @
        niMenu = 
            template: """
                <ul>
                    <li data-ng-repeat="item in tree">
                        <!-- directive: ni-menu-item -->
                    </li>
                </ul>
            """
            replace: true
            transclude: true
            restrict: 'M'
            scope:
                tree: '=niMenu'
    ]

angular.module('portfolioNgApp')
    .directive 'niMenuItem', ['$compile', '$location', ($compile, $location) ->
        niMenuItem =
            template: """
                <span>
                    <a ng-href="#!/card/{{item.id}}">{{item.name}}</a>
                </span>
            """
            replace: true
            transclude: true
            restrict: 'M'
            link: (scope, elm, attrs) ->
                if scope.item.children.length
                    childItem = $compile('<!-- directive: ni-menu item.children -->')(scope)
                    elm.append childItem
                1
    ]
