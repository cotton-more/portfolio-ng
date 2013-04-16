'use strict'

angular.module('portfolioNgApp')
    .directive 'niCard', [ ->
        niCard =
            restrict: 'M'
            replace: true
            transclude: true
            template: """
                <div>
                    <h3>{{card.name}}</h3>
                    <div ng-show="card.about">{{card.about}}</div>
                </div>
            """
        niCard
    ]

angular.module('portfolioNgApp')
    .directive 'niMenu', [ ->
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
                    <a ng-href="#!/cards/{{item.id}}">{{item.name}}</a>
                    <span class="btn btn-mini"><i class="icon-edit"></span>
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
