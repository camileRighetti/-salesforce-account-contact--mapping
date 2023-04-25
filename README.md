<img src="https://img.shields.io/badge/Database-SOQL-blue"> <img src="https://img.shields.io/badge/-Apex-blue"> <img src= "https://img.shields.io/badge/-Trigger-blue"> <img src=https://img.shields.io/badge/license-MIT-blue>

<img src="images/SalesforceCodex_Apex.png" align="right" width="300">
<h1>Salesforce Account-Related Contacts Creator with Notification Trigger</h1>

<b>This Salesforce Apex project creates Contact records and associates them with an existing Accounts based on the last name of the Contact. It also creates new Accounts using the Contact's last name as the Account name if a matching Account does not already exist. The project includes a trigger that sends a custom notification when ever a new Contact is inserted and associated with an Account.</b>

<h3>Use cases</h3>
This project is a valuable tool for businesses that want to stay on top of new leads or opportunities. With its alerts for new Contact records associated with existing Accounts, teams can receive immediate notifications and take prompt action to stay up-to-date and respond quickly to new opportunities. The project is versatile and can be applied to different business contexts, such as healthcare providers or financial institutions that require creating multiple Contact records. Additionally, the project allows the creation of Contacts related to Accounts based on the last name of the Contact, providing further flexibility for businesses.

<h3>Class Description</h3>

<h4>Contacts</h4>
This is the main class that contains the following methods:

<h5>createMembers(firstName, lastName)</h5> 
This method creates Contact records based on the family groups associated with the lastName parameter. It retrieves the family groups by calling the getFamilies method, then retrieves the Accounts associated with those family groups and creates a new Contact record for each one. The method returns a list of the created Contact records.

<h5>getFamilies(lastName)</h5> 
 This method returns a list of possible family group names based on the last name. It retrieves a list of last names by splitting the lastName parameter by space and then returns all possible combinations of those last names.

<h4>Main</h4>
This is an auxiliary class that runs a sequence of methods to create and test the Contacts class. It contains the following methods:

<h5>run</h5>
This method is used to execute the methods necessary to test the Contacts class, such as clearing existing records, creating new records, and running test assertions.

<h5>generateFamilies</h5>
This method creates a list of Account records with names representing family groups, such as 'Souza', 'Silva', and 'Souza Silva'. It then calls the createMembers method of the Contacts class with different first and last name parameters for each family group, and inserts the resulting Contact records.

<h5>asserts</h5>
This method contains the <b>test assertions</b> for the generateFamilies method. It retrieves the created Accounts and Contact records and checks if the expected number of Contact records were created for each family group.

<h4>ContactTriggerHandler </h4>
This class implements the logic to send the notification. It retrieves the information from the newly inserted Contact record and creates a custom notification message that is sent to the Salesforce users.

<h4>Triggers:</h4>
<h5>ContactsTrigger</h5>

This is a trigger that fires after a new Contact record is inserted, and calls the ContactTriggerHandler.afterInsert method.

<h3>How to Use</h3>

> Note: to use these classes, you need to have access to a Salesforce org and have Account and Contact objects.

1. Clone the project and save the classes inside your org:

    1.1 Inside the repository, click in code and copy the URL

    1.2 inside terminal use the code bellow:

    ```git
     git clone <https://github.com/camileRighetti/-salesforce-account-contact--mapping.git>
    ```

    1.3 After clonning the project, authorize your org using SFDX and then save the new classes you have cloned. This will make the classes be saved inside your org.

2. Now you are able to test the classes inside developer console

    2.1 Past the below code inside developer console, this will execute the tests and create the necessary records.

    ```apex
      Main.run();
    ```

    ![ezgif com-crop (4)](https://user-images.githubusercontent.com/122564426/232839610-0f9f0a67-685d-4c85-b6c8-d2c06045f254.gif)

    Note that 3 new Accounts were insert.

> Note that the Main class contains test assertions that can be used to validate the class behavior, If you want to modify the code, make sure the tests still pass after the changes.

3. Verify account and it's contacts

    Inside the new Accounts inserted, was also created it's related contacts.

![ezgif com-crop (5)](https://user-images.githubusercontent.com/122564426/232843439-22fc68fa-21ed-4555-9c08-eaa78b8519b7.gif)

4. Verify the notification for each Contact created:

![ezgif com-crop (6)](https://user-images.githubusercontent.com/122564426/234374291-8dbc5c7d-ca96-4243-ad97-b2c6b9eb601f.gif)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
