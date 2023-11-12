import * as httpm from 'typed-rest-client/HttpClient';
import * as hm from 'typed-rest-client/Handlers'
import * as cm from "./common"

export async function login(apiUrl: string, apiUsername: string, apiPassword: string): boolean {
    try {
        let url = apiUrl + '/users/sign_in';
        cm.log('INFO', 'called auth.login: ' + url);

        let requestBody = JSON.stringify({
            'user': {
              'email': apiUsername,
              'password': apiPassword
            }
        })
        
        let httpc: httpm.HttpClient = new httpm.HttpClient('vsts-node-api', undefined, { 
            allowRedirects: false,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            }
        });
        let res = await httpc.post(url, requestBody);
        let body = await res.readBody();
        cm.outputResponse(body, res.message);

        return true            
    } catch (err) {
        cm.log('ERROR', err.message);
    }
}