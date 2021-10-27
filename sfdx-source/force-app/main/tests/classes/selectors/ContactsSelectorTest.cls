/**
 * File Name: ContactsSelectorTest 
 * Description: 
 *
 * @author architect ir. Wilhelmus G.J. Velzeboer
 *
 * Copyright (c), W.G.J. Velzeboer,
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above author notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the author nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
@IsTest
private class ContactsSelectorTest
{
/*	@IsTest
	static void testBehavior()
	{
		Account account = new Account(Name = 'Test');
		insert account;
		Contact contact = new Contact(LastName = 'Smith', AccountId = account.Id);
		insert contact;

		Profile profile = [SELECT Id FROM Profile WHERE Name = 'Read Only'];

		User testUser = new User(
				Alias = 'Black',
				LastName = 'Black',
				Username = 'TestUser.Black@example.com',
				Email = 'TestUser.Black@example.com',

				EmailEncodingKey='UTF-8',
				LanguageLocaleKey='en_US',
				LocaleSidKey='en_US',
				TimeZoneSidKey='America/Los_Angeles',

				ProfileId = profile.Id
		);

		System.assert([SELECT COUNT() FROM Contact] == 1);

		List<Contact> testData = ContactsSelector.newInstance().selectByAccountId(new Set<Id> {account.Id});
		System.assert(testData.size() == 1, 'Test Data selectors Failed');


		System.runAs(testUser)
		{
			System.debug('Select Contact with AccountId : '+account.Id);
			List<Contact> contacts = ContactsSelector.newWithoutSharingInstance().selectByAccountId(new Set<Id> {account.Id});
			System.assert([SELECT COUNT() FROM Contact WHERE AccountId = :account.Id] == 0, 'SOQL 1 failed');
			System.assert([SELECT COUNT() FROM Contact] == 0, 'SOQL 2 failed');
			System.assert(contacts.size() == 1, 'Selector Failed');
		}
	}*/
}