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
private class AccountsServiceImplTest {
    @IsTest
    static void testCopyShippingCountryToContacts() {
        // GIVEN An account with contacts
        Set<Id> accountIds = new Set<Id>{
                fflib_IDGenerator.generate(Account.SObjectType)
        };
        Map<Id, String> shippingCountryByAccountId = new Map<Id, String> ();
        List<Account> accountRecords = new List<Account>();
        List<Contact> contactRecords = new List<Contact>();

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IAccounts accountsDomainMock = (IAccounts) mocks.mock(IAccounts.class);
        IContacts contactsDomainMock = (IContacts) mocks.mock(IContacts.class);
        IContactsSelector contactsSelectorMock = (IContactsSelector) mocks.mock(IContactsSelector.class);
        IAccountsSelector accountsSelectorMock = (IAccountsSelector) mocks.mock(IAccountsSelector.class);
        fflib_ISObjectUnitOfWork unitOfWorkMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);

        mocks.startStubbing();
        mocks.when(accountsDomainMock.getShippingCountryById()).thenReturn(shippingCountryByAccountId);
        mocks.when(accountsSelectorMock.selectSObjectsById(accountIds)).thenReturn(accountRecords);
        mocks.when(accountsDomainMock.getRecordIds()).thenReturn(accountIds);
        mocks.when(contactsSelectorMock.selectByAccountId(accountIds)).thenReturn(contactRecords);
        mocks.when(contactsDomainMock.getRecords()).thenReturn(contactRecords);
        mocks.stopStubbing();

        Application.Domain.setMock(Schema.Account.SObjectType, accountsDomainMock);
        Application.Domain.setMock(Schema.Contact.SObjectType, contactsDomainMock);
        Application.Selector.setMock(Schema.Contact.SObjectType, contactsSelectorMock);
        Application.UnitOfWork.setMock(unitOfWorkMock);

        // WHEN We copy the shipping country to the contacts
        System.Test.startTest();
        AccountsService.copyShippingCountryToContacts(accountIds);
        System.Test.stopTest();

        // THEN the contact shipping country should be retrieved from the account, set in the contacts and send to the database
        ((IAccounts) mocks.verify(accountsDomainMock)).getShippingCountryById();
        ((IAccounts) mocks.verify(accountsDomainMock)).getRecordIds();
        ((IContactsSelector) mocks.verify(contactsSelectorMock)).selectByAccountId(accountIds);
        ((IContacts) mocks.verify(contactsDomainMock)).setMailingCountryByAccountId(shippingCountryByAccountId);

        ((fflib_ISObjectUnitOfWork)
                mocks.verify(unitOfWorkMock,
                        mocks
                                .calls(1)
								.never()
                                .description('It should be invoked twice'))
        )
                .registerDirty(contactRecords);
    }

    @IsTest
    static void testRecalculateRating() {
        // Given
        List<Account> records = new List<Account>{
                new Account()
        };

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IAccounts domainMock = (IAccounts) mocks.mock(IAccounts.class);
        fflib_ISObjectUnitOfWork unitOfWorkMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);

        mocks.startStubbing();
        mocks.when(domainMock.getType()).thenReturn(Account.SObjectType);
        mocks.when(domainMock.selectByNumberOfEmployeesGreaterThan(fflib_Match.anyInteger()))
                .thenReturn(domainMock);
        mocks.when(domainMock.selectByNumberOfEmployeesLessThan(fflib_Match.anyInteger()))
                .thenReturn(domainMock);
        mocks.when(domainMock.setRating(fflib_Match.anyString()))
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
        ((fflib_ISObjectUnitOfWork) mocks.verify(unitOfWorkMock, 2)).registerDirty(records);
    }
}