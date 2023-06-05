/**
 * File Name: AccountsServiceImpl 
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
public with sharing class AccountsServiceImpl
		implements IAccountsService
{
	public void copyShippingCountryToContacts(Set<Id> accountIds)
	{
		copyShippingCountryToContacts(
				(IAccounts) Application.Domain.newInstance(accountIds)
		);
	}

	public void copyShippingCountryToContacts(List<Account> records)
	{
		copyShippingCountryToContacts(
				(IAccounts) Application.Domain.newInstance(records, Schema.Account.SObjectType)
		);
	}

	public void copyShippingCountryToContacts(List<Account> accounts, List<Contact> contacts)
	{
		copyShippingCountryToContacts(
				(IAccounts) Application.Domain.newInstance(accounts, Schema.Account.SObjectType),
				(IContacts) Application.Domain.newInstance(contacts, Schema.Contact.SObjectType)
		);
	}

	public void copyShippingCountryToContacts(IAccounts accounts)
	{
		copyShippingCountryToContacts(accounts, getContacts(accounts));
	}

	public void copyShippingCountryToContacts(IAccounts accounts, IContacts contacts)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		copyShippingCountryToContacts(unitOfWork, accounts, contacts);
		unitOfWork.commitWork();
	}

	public void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts)
	{
		copyShippingCountryToContacts(unitOfWork, accounts, getContacts(accounts));
	}

	public void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts, IContacts contacts)
	{
		Map<Id, String> shippingCountryByAccountId = accounts.getShippingCountryById();
		contacts.setMailingCountryByAccountId(shippingCountryByAccountId);
		unitOfWork.registerDirty(contacts.getRecords());
	}

	public void recalculateRating(Set<Id> accountIds)
	{
		recalculateRating(
				Accounts.newInstance(accountIds)
		);
	}

	public void recalculateRating(List<Account> records)
	{
		recalculateRating(
				Accounts.newInstance(records)
		);
	}

	public void recalculateRating(IAccounts accounts)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		recalculateRating(unitOfWork, accounts);
		unitOfWork.commitWork();
	}

	public void recalculateRating(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts)
	{
		setRating(
				unitOfWork,
				accounts.selectByNumberOfEmployeesGreaterThan(99),
				'Hot');

		setRating(
				unitOfWork,
				accounts.selectByNumberOfEmployeesLessThan(100),
				'Warm');
	}

	public void setRating(Set<Id> ids, String rating)
	{
		setRating(Accounts.newInstance(ids), rating);
	}

	public void setRating(List<Account> records, String rating)
	{
		setRating(Accounts.newInstance(records), rating);
	}

	public void setRating(IAccounts accounts, String rating)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		setRating(unitOfWork, accounts, rating);
		unitOfWork.commitWork();
	}

	public void setRating(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts, String rating)
	{
		unitOfWork.registerDirty(
			accounts.setRating(rating)
				.getRecords()
		);
	}


	private IContacts getContacts(IAccounts accounts)
	{
		return (IContacts) Application.Domain.newInstance(
				((IContactsSelector) Application.Selector.newInstance(Schema.Contact.SObjectType))
						.selectByAccountId(accounts.getRecordIds()),
				Schema.Contact.SObjectType
		);
	}
}