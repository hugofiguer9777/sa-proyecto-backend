'use strict';

module.exports = function(app) {

    var controller = require('../controller/appController');

    app.route('/')
        .get(controller.index);

    app.route('/login')
        .post(controller.login_usuario);

    app.route('/registrar')
        .post(controller.crear_usuario);

}