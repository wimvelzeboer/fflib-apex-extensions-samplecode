/**
 * File Name: AccountsServiceImplTest 
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
private class AccountsServiceImplTest
{
	@IsTest
	static void testCopyShippingCountryToContacts()
	{
		// GIVEN
		Id idA = fflib_IDGenerator.generate(Account.SObjectType);
		Id idB = fflib_IDGenerator.generate(Account.SObjectType);
		Id idC = fflib_IDGenerator.generate(Account.SObjectType);
		Set<Id> accountIds = new Set<Id>{ idA, idB, idC };
		Map<Id, String> shippingCountryByAccountId = new Map<Id, String>
		{
				idA => 'USA',
				idB => 'Ireland',
				idC => 'Holland'
		};
		List<Account> accountRecords = new List<Account>
		{
				new Account(Id = idA, Name = 'A', ShippingCountry = shippingCountryByAccountId.get(idA)),
				new Account(Id = idB, Name = 'B', ShippingCountry = shippingCountryByAccountId.get(idB)),
				new Account(Id = idC, Name = 'C', ShippingCountry = shippingCountryByAccountId.get(idC))
		};
		List<Contact> contactRecords = new List<Contact>
		{
				new Contact()
		};

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IAccounts accountsDomainMock = (IAccounts) mocks.mock(IAccounts.class);
		IContacts contactsDomainMock = (IContacts) mocks.mock(IContacts.class);
		IContactsSelector contactsSelectorMock = (IContactsSelector) mocks.mock(IContactsSelector.class);
		fflib_ISObjectUnitOfWork unitOfWorkMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);

		mocks.startStubbing();
		mocks.when(accountsDomainMock.getType()).thenReturn(Account.SObjectType);
		mocks.when(accountsDomainMock.getShippingCountryById()).thenReturn(shippingCountryByAccountId);
		mocks.when(accountsDomainMock.getRecordIds()).thenReturn(accountIds);
		mocks.when(contactsSelectorMock.sObjectType()).thenReturn(Contact.SObjectType);
		mocks.when(contactsSelectorMock.selectByAccountId(accountIds)).thenReturn(contactRecords);
		mocks.when(contactsDomainMock.getType()).thenReturn(Contact.SObjectType);
		mocks.when(contactsDomainMock.getRecords()).thenReturn(contactRecords);
		mocks.stopStubbing();

		Application.Domain.setMock(accountsDomainMock);
		Application.Domain.setMock(contactsDomainMock);
		Application.Selector.setMock(contactsSelectorMock);
		Application.UnitOfWork.setMock(unitOfWorkMock);

		// WHEN
		System.Test.startTest();
		AccountsService.copyShippingCountryToContacts(accountRecords);
		System.Test.stopTest();

		// THEN the contact records should be updated
		((IAccounts) mocks.verify(accountsDomainMock)).getShippingCountryById();
		((IAccounts) mocks.verify(accountsDomainMock)).getRecordIds();
		((IContactsSelector) mocks.verify(contactsSelectorMock)).selectByAccountId(accountIds);
		((IContacts) mocks.verify(contactsDomainMock)).setMailingCountryByAccountId(shippingCountryByAccountId);
		((fflib_ISObjectUnitOfWork) mocks.verify(unitOfWorkMock)).registerDirty(contactRecords);
	}

	@IsTest
	static void testRecalculateRating()
	{
		// Given
		List<Account> records = new List<Account>{new Account() };

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IAccounts domainMock = (IAccounts) mocks.mock(IAccounts.class);
		fflib_ISObjectUnitOfWork unitOfWorkMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);

		mocks.startStubbing();
		mocks.when(domainMock.getType()).thenReturn(Account.SObjectType);
		mocks.when(domainMock.selectByNumberOfEmployeesGreaterThan(fflib_Match.anyInteger()))
				.thenReturn(domainMock);
		mocks.when(domainMock.selectByNumberOfEmployeesLessThan(fflib_Match.anyInteger()))
				.thenReturn(domainMock);
		mocks.when(domainMock.getRecords()).thenReturn(records);
		mocks.stopStubbing();

		Application.Domain.setMock(domainMock);
		Application.UnitOfWork.setMock(unitOfWorkMock);

		// When
		System.Test.startTest();
		new AccountsServiceImpl().recalculateRating(unitOfWorkMock, domainMock);
		System.Test.stopTest();

		// THEN
		((IAccounts) mocks.verify(domainMock)).selectByNumberOfEmployeesGreaterThan(99);
		((IAccounts) mocks.verify(domainMock)).selectByNumberOfEmployeesLessThan(100);
		((fflib_ISObjectUnitOfWork)	mocks.verify(unitOfWorkMock)).registerDirty(records);
	}
}