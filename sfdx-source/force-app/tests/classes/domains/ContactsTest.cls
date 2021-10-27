/**
 * File Name: ContactsTest 
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
private class ContactsTest
{
	@IsTest
	static void itShouldGetTheMailingCountryById()
	{
		// GIVEN a Domain with contacts related to accounts
		Id accountIdA = fflib_IDGenerator.generate(Schema.Account.SObjectType);
		Id accountIdB = fflib_IDGenerator.generate(Schema.Account.SObjectType);

		List<Contact> contactRecords = new List<Contact>
		{
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdA),
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdA),
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdB)
		};
		IContacts domain = Contacts.newInstance(contactRecords);

		Map<Id, String> countryByAccountId = new Map<Id, String>
		{
				accountIdA => 'Ireland',
				accountIdB => 'Holland'
		};

		// WHEN
		System.Test.startTest();
		domain.setMailingCountryByAccountId(countryByAccountId);
		List<Contact> result = (List<Contact>) domain.getRecords();
		System.Test.stopTest();

		// THEN
		for (Contact contact : result)
		{
			System.assertEquals(
					countryByAccountId.get(contact.AccountId),
					contact.MailingCountry
			);
		}
	}
}