public with sharing class Contacts {
    public static List<Contact> createMembers(String firstName, String lastName) {
        //a partir do last name se utiliza o metodo get families
        //apos retornar as familias, deve ser possivel pegar o id de cada account > soql
        //apos pegar o valor de cada account pode atribuir ao campo de account id do contato

        List<String> lastNameGetFamily = getFamilies(lastName);
        List<Account> accs = [SELECT Id, Name, (SELECT Id, FirstName, LastName, AccountId FROM Contacts) FROM Account WHERE Name IN :lastNameGetFamily]; //retorna os ids de cada nome da lista que recebe o metodo getFamilies
        List<Account> newAccounts = new List<Account>();
        Set<String> accountsName = new Set<String>();

        //nao escontrar alguma familia, criar a que falta
        //if families does not contain last name do something
        //cria conta com o last name que nao tem

        for (Account acc : accs) {
            accountsName.add(acc.Name);
        }
        if (!lastNameGetFamily.equals(accountsName)) {
            Set<String> lastNameSet = new Set<String>(lastNameGetFamily); //copia lista de lastNameGetFam e torna um set
            lastNameSet.removeAll(accountsName);
            List<String> accsMissing = new List<String>(lastNameSet); //transforma set em list
            system.debug('removendo os valores iguais e deixando os diferentes em lastName get family' + accsMissing);
            for (String accName : accsMissing) {
                Account account = new Account(Name = accName);
                newAccounts.add(account); //insere na lista pra fazer insert
            }
        }

        insert newAccounts;
        accs.addAll(newAccounts);
        system.debug(accs + ' lista de accs depois de fazer o insert de novas contas');

        List<Contact> createdContacts = new List<Contact>();

        for (Account acc : accs) {
            Contact contactForCurrentAccount = new Contact(FirstName = firstName, LastName = lastName);
            contactForCurrentAccount.AccountId = acc.Id;
            createdContacts.add(contactForCurrentAccount);
        }

        return createdContacts;
    }

    public static List<String> getFamilies(String lastName) {
        List<String> families = new List<String>();
        List<String> lastNames = lastName.split(' '); //separa os sobrenomes exemplo silva santos, viram 2 elementos separados
        Integer lastNamesQuantity = lastNames.size(); //pega a quantidade de sobrenomes que estaram separados da lista acima

        for (Integer i = 0; i < lastNamesQuantity; i++) {
            families.addAll(buildLastNames(lastNames, lastNamesQuantity, i));
        }

        return families;
    }

    // o metodo build last names ira retornar combinacoes possiveis com o sobrenome

    private static List<String> buildLastNames(List<String> lastNames, Integer lastNamesQuantity, Integer startingIndex) {
        List<String> lastNameTemp = new List<String>();
        String currentLastName = '';
        for (Integer j = startingIndex; j < lastNamesQuantity; j++) {
            if (j > startingIndex) {
                currentLastName += ' ';
            }
            currentLastName += lastNames[j];
            lastNameTemp.add(currentLastName);
        }
        return lastNameTemp; //possiveis combinacoes de sobrenome
    }
}
