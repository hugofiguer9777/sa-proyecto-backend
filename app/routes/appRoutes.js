'use strict';
module.exports = function(app) {

    var routes = require('../controller/appController');

    app.route('/')
        .get(routes.index);

}