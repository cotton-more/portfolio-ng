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
        niMenu =
            template: """
                <ul class="unstyled">
                    <li data-ng-repeat="item in tree">
                        <!-- directive: ni-menu-item -->
                    </li>
                </ul>
            """
            replace: true
            transclude: true
            restrict: 'M'
            link: (scope, iElem, iAttr, ctrl)->
                angular.forEach scope.tree, (item) ->
                    if item.parent_id
                        iElem.removeClass 'unstyled'
            scope:
                tree: '=niMenu'
    ]

angular.module('portfolioNgApp')
    .directive 'niMenuItem', ['$compile', 'Menu', ($compile, Menu) ->
        selectMenuElement = (item) ->
            Menu.currentMenu = item

        niMenuItem =
            template: """
                <span>
                    <a ng-click="select(item)" id="test-{{item.id}}" ng-href="#!/menu/{{item.id}}/cards" ng-bind="item.name"></a>
                </span>
            """
            replace: true
            transclude: true
            restrict: 'M'
            link: ($scope, elm, attrs, ctrl) ->
                $scope.select = selectMenuElement

                if $scope.item.children.length
                    childItem = $compile('<!-- directive: ni-menu item.children -->')($scope)
                    elm.append childItem
                1
    ]
