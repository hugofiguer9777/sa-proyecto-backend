'user strict';

var mysql = require('mysql');

var conexion = mysql.createConnection({
    host:               '35.226.125.64',
    user:               'root',
    password:           'adminSA',
    database:           'proyectoSA',
    port:               3306
});

conexion.connect(function(err) {
    if(err) throw err;
});

module.exports = conexion;