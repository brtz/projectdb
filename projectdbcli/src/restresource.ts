import * as httpm from 'typed-rest-client/HttpClient';
import * as cm from './common';
import * as process from 'process';
import { minimatch } from 'minimatch';

export async function list(apiUrl:string, resource:string): Promise<string> {
    try {
        let url = apiUrl + '/' + resource
        cm.log('INFO', 'called list on resource ' + resource + ': ' + url);

        let jwt = cm.loadJWT();
        if (jwt == "") {
            process.exit(1);
        }

        let httpc: httpm.HttpClient = new httpm.HttpClient('vsts-node-api', undefined, { 
            allowRedirects: false,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ' + jwt
            }
        });

        let res = await httpc.get(url);
        let body = await res.readBody();
        
        if (res.message.statusCode == 200) {
            return body
        } else {
            cm.log('ERROR', 'could not list resource ' + resource);
            process.exit(1);
        }
    } catch (error) {
        cm.log('ERROR', error.message);
        process.exit(1);
    }
}

export async function find(apiUrl:string, resource:string, searchField:string, searchString:string): Promise<string> {
    try {
        let returnedList = JSON.parse(await list(apiUrl, resource));
        let result = [];
        returnedList.forEach(async (element) => {
            if (minimatch(element[searchField], searchString) == true) {
                result.push(element);
            }
        });
        return JSON.stringify(result);
    } catch (error) {
        cm.log('ERROR', error.message);
        process.exit(1);
    }
}
