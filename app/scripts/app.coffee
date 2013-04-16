'use strict'

angular.module('portfolioNgApp', ['ngResource'])
    .config ['$routeProvider', '$locationProvider', ($route, $location) ->
        $route
            .when '/',
                templateUrl: '/views/index.html'
            .when '/cards/:menuId',
                templateUrl: '/views/card.html'
                controller: 'CardListCtrl'
            .otherwise
                redirectTo: '/'

        $location.html5Mode(off).hashPrefix('!')
    ]
