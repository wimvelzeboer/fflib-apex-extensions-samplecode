@IsTest
private class SharingTest
{
	@IsTest
	static void testBehavior()
	{
		Account hiddenAccount = new Account(Name = 'Invisible', HiddenField__c = 'Test');
		Account visibleAccount = new Account(Name = 'Visible', HiddenField__c = 'Test');
		insert hiddenAccount;
		insert visibleAccount;

		Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
		User testUser = new User(Alias = 'Smith', Email='smith123@example.com',
				EmailEncodingKey='UTF-8', LastName='Smith', LanguageLocaleKey='en_US',
				LocaleSidKey='en_US', ProfileId = p.Id,
				TimeZoneSidKey='America/Los_Angeles', UserName='smith123@example.com.test');
		insert testUser;

		insert new AccountShare(AccountId = visibleAccount.Id, UserOrGroupId = testUser.Id, AccountAccessLevel='edit', OpportunityAccessLevel='edit');

		System.runAs(testUser)
		{

			System.assertEquals(1, new SharingSelector().getAll().size(), 'Expected to see only my own accounts');
			System.assertEquals(1, new UserModeSelector().getAll().size(), 'Expected to see only my own accounts');         // FLS & CRUD & SHARING See only accessable fields and respect sharing
			System.assertEquals(2, new NoSharingSelector().getAll().size(), 'Expected to see All accounts');
			System.assertEquals(1, new SystemModeWithSharingSelector().getAll().size(), 'Expected to see All accounts');    // NO FLS & CRUD but with sharing
			System.assertEquals(2, new SystemModeWithoutSharingSelector().getAll().size(), 'Expected to see All accounts'); // NO FLS & CRUD  & sharing
			//System.assertEquals(1, new fflibSelector().setDataAccess(fflib_SObjectSelector.DataAccess.USER_MODE).selectSObjectsById(new Set<Id>{ visibleAccount.Id, hiddenAccount.Id}).size(), 'fflib Selector did not work');
		}

		System.assertEquals(2, [SELECT Id FROM Account].size(), 'Expected to see all accounts');
		System.assertEquals(2, new SystemModeWithSharingSelector().getAll().size(), 'Expected to see All accounts');    // See all fields but respect sharing
		System.assertEquals(2, new SystemModeWithoutSharingSelector().getAll().size(), 'Expected to see All accounts'); // See all fields and ignore sharing
	}

	private with sharing class SharingSelector
	{
		public List<Account> getAll()
		{
			return [SELECT Id, Name FROM Account];
		}
	}

	private without sharing class NoSharingSelector
	{
		public List<Account> getAll()
		{
			return [SELECT Id, Name, HiddenField__c FROM Account];
		}
	}

	private without sharing class UserModeSelector
	{
		public List<Account> getAll()
		{
			return [SELECT Id, Name FROM Account WITH USER_MODE];
		}
	}

	private with sharing class SystemModeWithSharingSelector
	{
		public List<Account> getAll()
		{
			return [SELECT Id, Name, HiddenField__c FROM Account WITH SYSTEM_MODE];
		}
	}

	private without sharing class SystemModeWithoutSharingSelector
	{
		public List<Account> getAll()
		{
			return [SELECT Id, Name, HiddenField__c FROM Account WITH SYSTEM_MODE];
		}
	}

	private without sharing class fflibSelector extends fflib_SObjectSelector
	{
		public List<Schema.SObjectField> getSObjectFieldList()
		{
			return new List<Schema.SObjectField>
			{
					Account.Id,
					Account.Name,
					Account.HiddenField__c
			};
		}

		public SObjectType getSObjectType()
		{
			return Account.SObjectType;
		}
	}
}