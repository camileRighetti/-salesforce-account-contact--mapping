public with sharing class Contacts {
    public static List<Contact> createMembers(String firstName, String lastName) {
        //a partir do last name se utiliza o metodo get families
        //apos retornar as familias, deve ser possivel pegar o id de cada account > soql
        //apos pegar o valor de cada account pode atribuir ao campo de account id do contato

        List<String> lastNameGetFamily = getFamilies(lastName);
        List<Account> accs = [SELECT Id, Name, (SELECT Id, FirstName, LastName, AccountId FROM Contacts) FROM Account WHERE Name IN :lastNameGetFamily]; //retorna os ids de cada nome da lista que recebe o metodo getFamilies

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
        List<String> lastNames = lastName.split(' '); //separa os sobrenomes exemplo silva santos, virao 2 elementos separados
        Integer lastNamesQuantity = lastNames.size(); //pega a quantidade de sobrenomes que estaram separados da lista acima

        //para cada sobrenome na lista, o for vai rodar.
        for (Integer i = 0; i < lastNamesQuantity; i++) {
            families.addAll(buildLastNames(lastNames, lastNamesQuantity, i));
            //adiciona na lista familia,
            //metodo buildLastName passando como parametro lista de sobrenomes separados,
            //qtd de sobrenome na lista, passa i lembrando que i é lastNameQtd - 1
        }

        return families;
    }

    //passa uma lista de last names separados,
    //passa a qtd de elementos lastName,
    // recebe a qtd de iteracoes que sao baseadas justamente no size - 1
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
