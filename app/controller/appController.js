'use strict';

var models = require('../model/appModel');

exports.index = function(req, res) {
    console.log('Ruta index');
    res.send({ message: 'ProyectoSA - Backend' });
}