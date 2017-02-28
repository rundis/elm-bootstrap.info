'use strict';


require('./index.html');
var Elm = require('./Main');


var elm = Elm.Main.fullscreen();

elm.ports.updateAnalytics.subscribe(function (page) {
    ga('set', 'page', page);
    ga('send', 'pageview');
});
