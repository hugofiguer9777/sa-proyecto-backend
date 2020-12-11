'user strict';

var DataBaseHandler = require("./db");
var handler = new DataBaseHandler();

class Model {

    static login_usuario(email, password, result) {
        handler.getConnection().query("CALL login_usuario(?, ?)", [email, password], function(err, res) {
            if (err) {
                console.log("Error: ", err);
                result(err, null);
            }
            else {
                console.log(res[0]);
                result(null, res[0]);
            }
        });
    }

}

module.exports = Model;