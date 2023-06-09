public with sharing class Main {
    public static void run() {
        clearRecords();
        generateFamilies();
        asserts();
    }

    private static void generateFamilies() {
        Account souza = new Account(Name = 'Souza');
        Account souzaSilva = new Account(Name = 'Souza Silva');
        //Account silva = new Account(Name = 'silva');

        //insere as 3 account atraves de list
        insert new List<Account>{ souza, souzaSilva };

        List<Contact> members = new List<Contact>{};
        members.addAll(Contacts.createMembers('Ana', 'Souza')); //createMember é um metodo de Contacts e retorna uma List<Contact>
        members.addAll(Contacts.createMembers('Maria', 'Silva'));
        system.debug('quantidade de marias na lista de members' + members);
        members.addAll(Contacts.createMembers('Ana Maria', 'Souza Silva'));
        insert members;
        //cada lista member, tera uma lista atribuida. Essa lista tera o retorno de createMember
        //com os contatos criados para cada conta iterada.
    }

    /**
     * YOU CAN'T REMOVE/EDIT ANYTHING HERE
     * YOU MUST LOOK THESE ASSERTS TO UNDERSTAND WHAT IS EXPECTED AS AN OUTCOME
     * I SHOULD BE ABLE TO OPEN ANONYMOUS WINDOW ON DEVELOPER CONSOLE, TYPE "Main.run();" AND EXECUTE WITH NO ERRORS.
     */
    private static void asserts() {
        Account souza = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name = 'Souza'];
        Account silva = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name = 'Silva'];
        Account souzaSilva = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name = 'Souza Silva'];
        Assert.areEqual(2, souza.Contacts.size(), 'Souza should have 2 members: Ana and Ana Maria');
        Assert.areEqual(2, silva.Contacts.size(), 'Silva should have 2 members: Maria and Ana Maria');
        Assert.areEqual(1, souzaSilva.Contacts.size(), 'Souza Silva should have 1 member: Ana Maria');

        List<Contact> anas = [SELECT Id FROM Contact WHERE FirstName = 'Ana'];
        List<Contact> marias = [SELECT Id FROM Contact WHERE FirstName = 'Maria'];
        system.debug('lista de marias' + marias);
        List<Contact> anasMarias = [SELECT Id, AccountId FROM Contact WHERE FirstName = 'Ana Maria' ORDER BY Account.Name ASC]; //Silva, Souza, Souza Silva
        Assert.areEqual(1, anas.size(), 'It should have created only 1 Ana: Ana Souza.');
        Assert.areEqual(1, marias.size(), 'It should have created only 1 Maria: Maria Silva.');
        Assert.areEqual(3, anasMarias.size(), 'It should have created 1 Ana Maria for each family (Souza, Silva and Souza Silva): Ana Maria Souza Silva');

        Assert.areEqual(anasMarias.get(0).AccountId, silva.Id, 'The first Ana Maria in this SOQL should be from Silva\'s family');
        Assert.areEqual(anasMarias.get(1).AccountId, souza.Id, 'The second Ana Maria in this SOQL should be from Souza\'s family');
        Assert.areEqual(anasMarias.get(2).AccountId, souzaSilva.Id, 'The third Ana Maria in this SOQL should be from Souza Silva\'s family');
    }

    /**
     * THIS METHOD IS IMPORTANT BECAUSE
     * IF YOU EXECUTE Main.run() MORE THAN ONCE
     * THE ASSERTS WILL FAIL
     * SO.. JUST DO NOT TOUCH HERE.. :)
     */
    private static void clearRecords() {
        delete [SELECT Id FROM Account WHERE Name IN ('Souza', 'Silva', 'Souza Silva')];
    }
}
