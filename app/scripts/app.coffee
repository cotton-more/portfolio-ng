'use strict'

angular.module('portfolioNgApp', ['ngResource'])
    .config ['$routeProvider', '$locationProvider', ($route, $location) ->
        $location.html5Mode(on).hashPrefix('!')
        $route
            .when '/portfolio',
                templateUrl: 'views/portfolio.html'
                controller: 'PortfolioCtrl'
            .otherwise
                redirectTo: '/portfolio'
    ]
