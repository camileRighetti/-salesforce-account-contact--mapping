<img src="https://img.shields.io/badge/Database-SOQL-blue"> <img src="https://img.shields.io/badge/-Apex-blue"> <img src=https://img.shields.io/badge/license-MIT-blue>
<img src="image/../images/SalesforceCodex_Apex.png" align="right" width="300">  
#Salesforce Account Related Contacts Creator
This Salesforce Apex class provides a method to create Contact records based on the last name of a family group. The class contains two methods, one to create the Contact records and another to retrieve the family groups based on the last name.

###Use cases
This project can be used in any business context that requires creating multiple Contact records based on a Account Name, such as healthcare providers or financial institutions.

###Class Description

####Contacts
This is the main class that contains the following methods:

#####createMembers
This method receives two parameters, firstName and lastName, and creates Contact records based on the family groups associated with the lastName parameter. It retrieves the family groups by calling the getFamilies method, then retrieves the Accounts associated with those family groups and creates a new Contact record for each one. The method returns a list of the created Contact records.

#####getFamilies
This method receives a lastName parameter and returns a list of possible family group names based on the last name. It retrieves a list of last names by splitting the lastName parameter by space, and then returns all possible combinations of those last names.

#####Main
This is an auxiliary class that runs a sequence of methods to create and test the Contacts class. It contains the following methods:

#####run
This method is used to execute the methods necessary to test the Contacts class, such as clearing existing records, creating new records, and running test assertions.

#####generateFamilies
This method creates a list of Account records with names representing family groups, such as 'Souza', 'Silva', and 'Souza Silva'. It then calls the createMembers method of the Contacts class with different first and last name parameters for each family group, and inserts the resulting Contact records.

####asserts
This method contains the <b>test assertions</b> for the generateFamilies method. It retrieves the created Accounts and Contact records and checks if the expected number of Contact records were created for each family group.

##How to Use
To use this class, you need to have access to a Salesforce org and have the necessary permissions to create Apex classes and execute anonymous Apex.

Copy the code of the Contacts and Main classes.
Create a new Apex class in your Salesforce org and paste the code.
Open the Developer Console and execute the Main.run() method. This will execute the tests and create the necessary records.
Note that the Main class contains test assertions that can be used to validate the class behavior. If you want to modify the code, make sure the tests still pass after the changes.
