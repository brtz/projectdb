import * as http from 'http';
import * as restm from 'typed-rest-client/RestClient';
import * as process from 'process';
import * as fs from 'fs';

export function saveJWT(jwt: string): boolean {
    try {
        fs.writeFileSync('/tmp/.projectdbcli_jwt', jwt, { flag: 'w+' });
        log('INFO', 'saved JWT to file');
        return true;
    } catch (error) {
        log('ERROR', 'could not save JWT to file');
        return false;
    }
}

export function loadJWT(): string {
    try {
        let jwt = fs.readFileSync('/tmp/.projectdbcli_jwt', 'utf8');
        log('INFO', 'loaded JWT to file');
        return jwt;
    } catch (error) {
        log('ERROR', 'could not load JWT from file');
        return "";
    }
}

export function getEnv(name: string): string {
    let val = process.env[name];
    return val;
}

export function banner(title: string): void {
    if (getEnv('PROJECTDBCLI_SILENT') != undefined) {
        return
    }
    console.log('=============================================');
    console.log('\t' + title);
    console.log('=============================================');
}

export function log(severity: string, content: string): void {
    if (getEnv('PROJECTDBCLI_SILENT') != undefined) {
        return
    }
    console.log('[' + severity + '] ' + content);
}

//
// Utility functions
//
export async function outputResponse(body: string, message?: http.IncomingMessage) {
    if (message) {
        if (message.statusCode) {
            console.log('status', message.statusCode);
        }

        if (message.rawHeaders) {
            console.log('headers:' + JSON.stringify(message.rawHeaders));
        }
    }

    if (body) {
        let obj = JSON.parse(body.toString());
        console.log('response from ' + obj.url);
        if (obj.data) {
            console.log('data:', obj.data);
        }
    }
}

//
// This is often not needed.  In this case, using httpbin.org which echos the object
// in the data property of the json.  It's an artifact of sample service used.
// But it's useful to note that we do offer a processing function which is invoked on the returned json.
//
export function httpBinOptions(): restm.IRequestOptions {
    let options: restm.IRequestOptions = <restm.IRequestOptions>{};
    options.responseProcessor = (obj: any) => {
        return obj['data'];
    }

    return options;
}
