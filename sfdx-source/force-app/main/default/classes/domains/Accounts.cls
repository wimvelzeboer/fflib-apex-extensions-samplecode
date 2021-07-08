/**
 * File Name: Accounts 
 * Description: Domain implementation for Account records
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
public with sharing class Accounts
		extends SObjects
		implements IAccounts
{
	// Class constructor
	@TestVisible
	private Accounts(List<SObject> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	// Method to create new domain instances via record Ids
	public static IAccounts newInstance(Set<Id> ids)
	{
		return (IAccounts) Application.Domain.newInstance(ids);
	}

	// Method to create new domain instances via records
	public static IAccounts newInstance(List<SObject> records)
	{
		return (IAccounts) Application.Domain.newInstance(records, Schema.Account.sObjectType);
	}

	public List<Account> getAccounts()
	{
		return (List<Account>) getRecords();
	}

	public Set<String> getShippingCountries()
	{
		Set<String> result = new Set<String>();
		for (Account record : getAccounts())
		{
			result.add(record.ShippingCountry);
		}
		return result;
	}

	public Map<Id, String> getShippingCountryById()
	{
		Map<Id, String> result = new Map<Id, String>();
		for (Account record : getAccounts())
		{
			if (String.isBlank(record.ShippingCountry)) continue;

			result.put(record.Id, record.ShippingCountry);
		}
		return result;
	}

	public IAccounts recalculateRating()
	{
		selectByNumberOfEmployeesGreaterThan(99)
				.setRating('Hot');

		selectByNumberOfEmployeesLessThan(100)
				.setRating('Warm');

		return (IAccounts) this;
	}

	public IAccounts selectByNumberOfEmployeesGreaterThan(Integer amount)
	{
		List<Account> result = new List<Account>();
		for (Account record : getAccounts())
		{
			if (record.NumberOfEmployees != null && record.NumberOfEmployees > amount)
			{
				result.add(record);
			}
		}
		return (IAccounts) new Accounts(result);
	}

	public IAccounts selectByNumberOfEmployeesLessThan(Integer amount)
	{
		List<Account> result = new List<Account>();
		for (Account record : getAccounts())
		{
			if (record.NumberOfEmployees != null && record.NumberOfEmployees < amount)
			{
				result.add(record);
			}
		}
		return (IAccounts) new Accounts(result);
	}

	public void setRating(String value)
	{
		for (Account record : getAccounts())
		{
			record.Rating = value;
		}
	}

	// Sub-class constructor
	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_IDomain construct(List<Object> objectList)
		{
			return (fflib_IDomain) new Accounts((List<SObject>) objectList);
		}
	}
}