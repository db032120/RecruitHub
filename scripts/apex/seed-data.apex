Account holding = new Account(Name = 'RecruitHub Candidates');
insert holding;

Contact asha = new Contact(FirstName = 'Asha', LastName = 'Rao', AccountId = holding.Id,
    Current_Employer__c = 'Acme Corp', Years_Experience__c = 5);
insert asha;

Job_Posting__c openJob = new Job_Posting__c(Name = 'Senior Salesforce Developer', Status__c = 'Open');
Job_Posting__c closedJob = new Job_Posting__c(Name = 'QA Analyst', Status__c = 'Closed');
insert new List<Job_Posting__c>{ openJob, closedJob };

Database.SaveResult good = Database.insert(
    new Application__c(Job_Posting__c = openJob.Id, Candidate__c = asha.Id), false);
Database.SaveResult bad = Database.insert(
    new Application__c(Job_Posting__c = closedJob.Id, Candidate__c = asha.Id), false);

System.debug('Open job success? ' + good.isSuccess());
System.debug('Closed job success? ' + bad.isSuccess());
if (!bad.isSuccess()) {
    System.debug('Blocked with: ' + bad.getErrors()[0].getMessage());
}