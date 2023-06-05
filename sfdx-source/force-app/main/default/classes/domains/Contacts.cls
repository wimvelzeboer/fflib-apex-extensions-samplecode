/**
 * File Name: Contacts
 * Description: Domain implementation for Contact records
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
public with sharing class Contacts
		extends fflib_SObjects2
		implements IContacts
{
	// Class constructor
	@TestVisible
	private Contacts(List<SObject> records)
	{
		super(records, Schema.Contact.SObjectType);
	}

	// Method to create new domain instances via record Ids
	public static IContacts newInstance(Set<Id> ids)
	{
		return (IContacts) Application.Domain.newInstance(ids);
	}

	// Method to create new domain instances via records
	public static IContacts newInstance(List<SObject> records)
	{
		return (IContacts) Application.Domain.newInstance(records, Schema.Contact.SObjectType);
	}

	public List<Contact> getContacts()
	{
		return (List<Contact>) getRecords();
	}

	public void setMailingCountryByAccountId(Map<Id, String> countryByAccountId)
	{
		for (Contact record : getContacts())
		{
			if (countryByAccountId.containsKey(record.AccountId))
			{
				record.MailingCountry = countryByAccountId.get(record.AccountId);
			}
		}
	}

	// Sub-class constructor
	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_IDomain construct(List<Object> objectList)
		{
			return (fflib_IDomain) new Contacts((List<SObject>) objectList);
		}
	}
}