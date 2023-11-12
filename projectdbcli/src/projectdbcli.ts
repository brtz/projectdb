import * as cm from './common';
import { parse } from 'ts-command-line-args';
import * as process from 'process';
import * as auth from './auth';
import * as restresource from './restresource';

interface ICLIArguments {
    command: string;
    resource: string;
    searchField: string;
    searchString: string;
    help?: boolean;
}

export const args = parse<ICLIArguments>(
    {
        command: { type: String, alias: 'c', description: 'command (auth, list, find)' },
        resource: { type: String, alias: 'r', description: 'resource to modify (users, projects, environments, secrets)' },
        searchField: { type: String, alias: 'f', optional: true, description: 'Field to search in objects'},
        searchString: { type: String, alias: 's', optional: true, description: 'Content in field to match'},
        help: { type: Boolean, optional: true, alias: 'h', description: 'Prints this usage guide' }
    },
    {
        helpArg: 'help',
        footerContentSections: [{ header: 'Footer', content: 'ProjectDB cli' }]
    }
);

cm.banner('ProjectDB Command Line Interface');

let apiUrl = cm.getEnv("PROJECTDBCLI_API_URL");
let apiUsername = cm.getEnv("PROJECTDBCLI_API_USERNAME");
let apiPassword = cm.getEnv("PROJECTDBCLI_API_PASSWORD");

if ((args.command == 'auth') && ((apiUrl == undefined) || (apiUsername == undefined) || (apiPassword == undefined))) {
    cm.log('ERROR', 'apiUrl or apiUsername or apiPassword are not set, aborting.');
    process.exit(1);
}

switch (args.resource) {
    case 'users':
        switch (args.command) {
            case 'auth':
                auth.login(apiUrl, apiUsername, apiPassword);
                break;
            default:
                cm.log('ERROR', 'Not implemented, ' + args.resource + ' ' + args.command);
                process.exit(1);
        }
        break;
    default:
        switch (args.command) {
            case 'list':
                console.log(JSON.parse(await restresource.list(apiUrl, args.resource)));
                break;
            case 'find':
                console.log(JSON.parse(await restresource.find(apiUrl, args.resource, args.searchField, args.searchString)));
        }
        break;
}
