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

// starts a simple http server locally on port 3000
server.listen(3000, '127.0.0.1', () => {
console.log('Listening on 127.0.0.1:3000');
});

// run with `node server.mjs`

