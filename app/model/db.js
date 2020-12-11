const mysql = require("mysql");

function DataBaseHandler() {
  this.connection = null;
}

DataBaseHandler.prototype.createConnection = function () {
  this.connection = mysql.createConnection({
    host:       process.env.MYSQL_HOST ? process.env.MYSQL_HOST : '35.226.125.64',
    user:       process.env.MYSQL_USER ? process.env.MYSQL_USER : 'root',
    password:   process.env.MYSQL_PASSWORD ? process.env.MYSQL_PASSWORD : 'adminSA',
    port:       process.env.MYSQL_PORT ? process.env.MYSQL_PORT : 3306,
    database:   process.env.MYSQL_DATABASE ? process.env.MYSQL_DATABASE : 'proyectoSA'
  });

  this.connection.connect(function (err) {
      if (err) {
          console.error("error connecting " + err.stack);
          return null;
      }
      console.log("connected as id " + this.threadId);
  });
  return this.connection;
};

DataBaseHandler.prototype.getConnection = function () {
  if(this.connection) return this.connection;
  return this.createConnection();
}

module.exports = DataBaseHandler;