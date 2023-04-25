public with sharing class ContactTriggerHandler {
    public static void afterInsert(List<Contact> newContacts) {
        //envia um alerta toda vez que um contato for inserido no salesforce e esse contact tem um account id
        for (Contact ctt : newContacts) {
            if (ctt.AccountId != null) {
                CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE developerName = 'accountContactRelatedNew'];

                system.debug('notificacao comeca');

                //cria uma messangem custom notification
                Messaging.CustomNotification notification = new Messaging.CustomNotification();
                notification.setTitle('um novo contato foi adicionado a conta ' + ctt.AccountName__c);
                notification.setBody('o contato ' + ctt.FirstName + ' ' + ctt.LastName + ' foi adicionado na conta ' + ctt.AccountName__c);
                notification.setNotificationTypeId(type.Id);
                notification.setTargetId(ctt.AccountId);

                try {
                    notification.send(new Set<String>{ UserInfo.getUserId() });
                } catch (Exception e) {
                    System.debug('Problem sending notification: ' + e.getMessage());
                }
            }
        }
    }
}
