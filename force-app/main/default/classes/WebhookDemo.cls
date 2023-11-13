/**************************
 Author: Penko Gadzhev
 Description: Class to handle webhooks from GitHub
 Date: 09.11.2023
 **************************/
@RestResource(urlMapping='/api/Webhooks/pushDetailsdemo/*')
// https://testcompany297-dev-ed.develop.my.site.com/services/apexrest/api/Webhooks/pushDetailsdemo
global with sharing class WebhookDemo {
   @HttpPost
   global static void handleNotification() {

    try {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String hashedval = request.headers.get('X-Hub-Signature-256');
        System.debug('hashedval'+hashedval);
        Blob bB = request.requestBody;
        System.debug('bB'+bB.toString());
        System.debug('Secret value Matched and source can be trusted!');

        JSONParser parser = JSON.createServer(request.requestBody.toString());
        pusher ps;
        head_commit hc;
        String repo;
        while (parser.nextToken() != null) {
            if (parser.getText() == 'pusher') {
                System.debug('Inside pusher');

                parser.nextToken();
                ps = (pusher)parser.readValueAs(pusher.class);
                System.debug('ps'+ps);
            }
            if (parser.getText() == 'head_commit') {
                System.debug('Inside head_commit') {
                    parser.nextToken();
                   hc = (head_commit)parser.readValueAs(head_commit.class);
                    System.debug(hc);
                }
            }
            if (parser.getText() == 'full_name') {
                System.debug('Inside full_name') {
                    parser.nextToken();
                    repo = parser.getText();
                    System.debug(repo);
                }
            }
        }

        // Create GitHub_PushDetails__c  based on received details
        GitHub_PushDetails__c detail = new GitHub_PushDetails__c();
        detail.Name = ps!=null ? ps.name : '';
        detail.Commiter_Name__c = ps!=null ? ps.committer.name : '';
        detail.CommiterEmail__c = ps!=null ? ps.committer.email : '';
        detail.CommitMessage__c = ps!=null ? ps.commits.message : '';
        insert detail;
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.seari)

    } catch (Exception e) {
        System.debug('Exception Happened:' + e.getMessage());
    }
   }
}