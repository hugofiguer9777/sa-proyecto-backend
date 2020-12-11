const express = require('express');
const app = express();
const bodyParser = require('body-parser');

var cors = require('cors');

port = '3000';

app.listen(port, function() {
  console.log('Servidor escuchando en el puerto 3000');
});

app.use(cors());
app.use(bodyParser.json({ limit: '5mb', extended: true }));

var routes = require('./app/routes/appRoutes');
routes(app);