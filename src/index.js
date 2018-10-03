'use strict';


require('./index.html');
const {Elm} = require('./Main.elm');


var elm = Elm.Main.init({});

elm.ports.updateAnalytics.subscribe(function (page) {
    ga('set', 'page', page);
    ga('send', 'pageview');
});
