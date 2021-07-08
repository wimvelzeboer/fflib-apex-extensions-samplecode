/**
 * File Name: AccountsTriggerHandler
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
public with sharing class AccountsTriggerHandler extends fflib_SObjectDomain
{
	public AccountsTriggerHandler(List<Account> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	public override void onBeforeInsert()
	{
		recalculateRating();
	}

	public override void onBeforeUpdate(Map<Id, SObject> existingRecords)
	{
		onChangedNumberOfEmployeesRecalculateRating();
		onChangedCountryCopyValueToContacts();
	}

	private void onChangedCountryCopyValueToContacts()
	{
		List<SObject> changedRecords = getChangedRecords(new Set<SObjectField> {Schema.Account.ShippingCountry});

		if (changedRecords.isEmpty()) return;

		AccountsService.copyShippingCountryToContacts((List<Account>) changedRecords);
	}

	private void onChangedNumberOfEmployeesRecalculateRating()
	{
		List<SObject> changedRecords = getChangedRecords(new Set<SObjectField> {Schema.Account.NumberOfEmployees});

		if (changedRecords.isEmpty()) return;

		new AccountsTriggerHandler(changedRecords)
				.recalculateRating();
	}

	private void recalculateRating()
	{
		Accounts.newInstance(getRecords())
				.recalculateRating();
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new AccountsTriggerHandler(sObjectList);
		}
	}
}


