'use strict';


require('./index.html');
var Elm = require('./Main.elm').Elm;


var elm = Elm.Main.init({});

elm.ports.updateAnalytics.subscribe(function (page) {
    ga('set', 'page', page);
    ga('send', 'pageview');
});
