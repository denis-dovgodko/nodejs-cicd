// server.mjs
import express from 'express';
import { engine } from 'express-handlebars';

const server = express();

server.engine('handlebars', engine())
    .set('view engine', 'handlebars')
    .set('views', './views')
    .get('/', (req, res) => {
    res.render('index');
});

// starts a simple http server locally on port 80
server.listen(80, '0.0.0.0', () => {
console.log('Listening on 0.0.0.0:80');
});

// run with `node server.mjs`

