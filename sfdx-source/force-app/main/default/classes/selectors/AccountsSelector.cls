/**
 * File Name: AccountsSelector 
 * Description: Selector implementation for Account records
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
public virtual without sharing class AccountsSelector
		extends fflib_SObjectSelector
		implements IAccountsSelector
{
	/**
	 * Runs the query in User Mode, respecting FLS, CRUD & sharing rules
	 *
	 * @return New instance of the selector
	 */
	public static IAccountsSelector newInstance()
	{
		return (IAccountsSelector)
				((fflib_SObjectSelector) Application.Selector.newInstance(Schema.Account.SObjectType))
				.setDataAccess(fflib_SObjectSelector.DataAccess.USER_MODE);
	}

	/**
	 * Runs the query in System Mode, disabling FLS, CRUD & sharing rules
	 *
	 * @return New instance of the selector
	 */
	public static IAccountsSelector newElevatedInstance()
	{
		return (IAccountsSelector)
				((fflib_SObjectSelector) Application.Selector.newInstance(Schema.Account.SObjectType))
						.setDataAccess(fflib_SObjectSelector.DataAccess.SYSTEM_MODE);
	}

	public AccountsSelector()
	{
		super();
	}

	public virtual List<Schema.SObjectField> getSObjectFieldList()
	{
		List<SObjectField> sObjectFields = new List<Schema.SObjectField>
		{
				Account.Id,
				Account.AccountNumber,
				Account.Name,
				Account.NumberOfEmployees,
				Account.Rating,
				Account.ShippingCountry
		};
		return sObjectFields;
	}

	public Schema.SObjectType getSObjectType()
	{
		return Account.SObjectType;
	}

	public virtual List<Account> selectById(Set<Id> idSet)
	{
		return (List<Account>) selectSObjectsById(idSet);
	}

	public virtual Database.QueryLocator queryLocatorAll()
	{
		return Database.getQueryLocator(
				newQueryFactory().toSOQL()
		);
	}
}