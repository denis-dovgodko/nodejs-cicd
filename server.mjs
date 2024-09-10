// server.mjs
import express from 'express';
import { engine } from 'express-handlebars';
import https from 'https';
import fs from 'fs';

const server = express();


try {
    const options = {
    cert: fs.readFileSync('/etc/letsencrypt/live/denisdovgodko.duckdns.org/fullchain.pem'),
    key: fs.readFileSync('/etc/letsencrypt/live/denisdovgodko.duckdns.org/privkey.pem')
    };
}
catch(error){
    console.log('certificate/key does not exist');
}

server.engine('handlebars', engine())
    .set('view engine', 'handlebars')
    .set('views', './views')
    .get('/', (req, res) => {
    res.render('index');
});


server.listen(80, '127.0.0.1', () => {
console.log('Listening on 127.0.0.1:80');
});

if (options.cert && options.key) {
    https.createServer(options, server).listen(443, '0.0.0.0', () => {
        console.log('Listening on 0.0.0.0:443');
    });
}
