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
    } catch (Exception e) {
        System.debug('Exception Happened:' + e.getMessage());
    }
   }
}