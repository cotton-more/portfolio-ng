'use strict'

angular.module('portfolioNgApp')
    .directive 'niCard', [ ->
        template = """
            <div>
                <h3>{{card.name}}</h3>
                <img src="http://placehold.it/600x480/&text={{card.name}}" class="img-rounded img-polaroid">
                <div ng-show="card.about">{{card.about}}</div>
            </div>
        """
        niCard =
            restrict: 'M'
            replace: true
            scope:
                card: '=niCard'
            template: template
    ]

angular.module('portfolioNgApp')
    .directive 'niMenu', [ ->
        niMenu =
            template: """
                <ul>
                    <li data-ng-repeat="item in tree">
                        <!-- directive: ni-menu-item item -->
                    </li>
                </ul>
            """
            replace: true
            restrict: 'M'
            scope:
                tree: '=niMenu'
    ]

angular.module('portfolioNgApp')
    .directive 'niMenuItem', ['$compile', 'Menu', ($compile, Menu) ->
        selectMenuElement = (item) ->
            Menu.currentMenu = item

        cardsTemplate = '<a ng-href="#!/menu/{{item.id}}/cards" ng-click="select(item)">{{item.name}}</a>'
        noCardsTemplate = '<span class="muted" ng-click="select(item)">{{item.name}}</span>'

        linker = (scope, elm, attrs, ctrl) ->
            scope.select = selectMenuElement

            if scope.item.cards_len
                template = cardsTemplate
            else
                template = noCardsTemplate

            elm.html template

            $compile(elm.contents())(scope)

            if scope.item.children.length
                childitem = $compile('<!-- directive: ni-menu item.children -->')(scope)
                elm.append childitem

        niMenuItem =
            restrict: 'M'
            replace: true
            template: '<div></div>'
            link: linker

        niMenuItem
    ]
