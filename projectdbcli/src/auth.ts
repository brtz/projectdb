import * as httpm from 'typed-rest-client/HttpClient';
import * as cm from './common'
import * as process from 'process'


export async function login(apiUrl: string, apiUsername: string, apiPassword: string): void {
    try {
        let url = apiUrl + '/users/sign_in';
        cm.log('INFO', 'called auth.login: ' + url);

        let requestBody = JSON.stringify({
            'user': {
              'email': apiUsername,
              'password': apiPassword
            }
        });

        let httpc: httpm.HttpClient = new httpm.HttpClient('vsts-node-api', undefined, {
            allowRedirects: false,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            }
        });

        let res = await httpc.post(url, requestBody);

        if (res.message.statusCode == 200) {
            let jwt = res.message.headers['authorization'].replace('Bearer ', '');
            cm.saveJWT(jwt);
            cm.log('INFO', 'successfully logged in');
        } else {
            cm.log('ERROR', 'api auth failed, statusCode: ' + res.message.statusCode);
            process.exit(1);
        }
    } catch (err) {
        cm.log('ERROR', err.message);
    }
}