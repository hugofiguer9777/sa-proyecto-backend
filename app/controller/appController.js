'use strict';

var model = require('../model/appModel');

exports.index = function(req, res) {
    console.log('Ruta index');
    res.send({ message: 'ProyectoSA - Backend' });
};

exports.login_usuario = function(req, res) {
    var body = req.body;
    var email = body.email;
    var password = body.password;

    model.login_usuario(email, password, function(err, msg) {
        if(err) { res.status(404).send(err); }
        else {
            res.json({ message: msg[0]['result'] });
        }
    });
};

exports.crear_usuario = function(req, res) {
    var body = req.body;
    var nombre = body.nombre; 
    var apellido = body.apellido; 
    var email = body.email;
    var password = body.password;
    var celular = body.celular;
    var foto = body.foto;
    var tipo_usuario = body.tipo_usuario

    model.crear_usuario(nombre, apellido, email, password, celular, foto, tipo_usuario, function(err, msg) {
        if(err) { res.status(500).send(err); }
        else {
            res.json({ message: 1 });
        }
    });
};