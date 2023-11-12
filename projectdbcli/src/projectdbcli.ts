import * as rm from 'typed-rest-client/RestClient';
import * as httpm from 'typed-rest-client/HttpClient';
import * as cm from './common';
import * as fs from 'fs';
import * as path from 'path';
import { parse } from 'ts-command-line-args';
import * as process from 'process';
import * as auth from './auth';

let restc: rm.RestClient = new rm.RestClient('rest-samples', apiUrl);
export async function run() {
    try {

        //
        // Get Resource: strong typing of resource(s) via generics.
        // In this case httpbin.org has a response structure
        // response.result carries the resource(s)
        //
        
        cm.heading('get rest obj');
        /*
        let restRes: rm.IRestResponse<cm.HttpBinData> = await restc.get<cm.HttpBinData>('get');
        console.log(restRes.statusCode, restRes.result['url']);
        */

        //
        // Create and Update Resource(s)
        // Generics <T,R> are the type sent and the type returned in the body.  Ideally the same in REST service
        //
        /*
        interface HelloObj {
            message: string;
        }
        let hello: HelloObj = <HelloObj>{ message: "Hello World!" };
        let options: rm.IRequestOptions = cm.httpBinOptions();

        cm.heading('create rest obj');
        let hres: rm.IRestResponse<HelloObj> = await restc.create<HelloObj>('/post', hello, options);
        console.log(hres.result);

        cm.heading('update rest obj');
        hello.message += '!';

        // you can also specify a full url (not relative) per request
        hres = await restc.update<HelloObj>('https://httpbin.org/patch', hello, options);
        console.log(hres.result);

        cm.heading('options rest call');
        let ores: rm.IRestResponse<void> = await restc.options<void>('', options);
        console.log(ores.statusCode);
        */
    }
    catch (err) {
        console.error('Failed: ' + err.message);
    }
}

interface ICLIArguments {
    command: string;
    resource: string;
    help?: boolean;
}

export const args = parse<ICLIArguments>(
    {
        command: { type: String, alias: 'c', description: 'command (auth, list, show, create, update, delete, search)' },
        resource: { type: String, alias: 'r', description: 'resource to modify (user, project, environment, secret)' },
        help: { type: Boolean, optional: true, alias: 'h', description: 'Prints this usage guide' },
    },
    {
        helpArg: 'help',
        footerContentSections: [{ header: 'Footer', content: 'ProjectDB cli' }],
    }
);

cm.banner('ProjectDB Command Line Interface');

let apiUrl = cm.getEnv("PROJECTDBCLI_API_URL");
let apiUsername = cm.getEnv("PROJECTDBCLI_API_USERNAME");
let apiPassword = cm.getEnv("PROJECTDBCLI_API_PASSWORD");

if ((apiUrl == undefined) || (apiUsername == undefined) || (apiPassword == undefined)) {
    cm.log('ERROR', 'apiUrl or apiUsername or apiPassword are not set, aborting.');
    process.exit(1);
}

switch (args.resource) {
    case "user":
        switch (args.command) {
            case "auth":
                auth.login(apiUrl, apiUsername, apiPassword);
                break;
        }
        break;
}

