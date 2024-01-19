/**
 * File Name: ContactsSelector
 * Description: Selector implementation for Contact records
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
public virtual inherited sharing class ContactsSelector
		extends fflib_SObjectSelector
		implements IContactsSelector
{
	/**
	 * Runs the query in User Mode, respecting FLS, CRUD & sharing rules
	 *
	 * @return New instance of the selector
	 */
	public static IContactsSelector newInstance()
	{
		return (IContactsSelector)
				((fflib_SObjectSelector) Application.Selector.newInstance(Schema.Contact.SObjectType))
						.setDataAccess(fflib_SObjectSelector.DataAccess.USER_MODE);
	}

	/**
	 * Runs the query in System Mode, disabling FLS, CRUD & sharing rules
	 *
	 * @return New instance of the selector
	 */
	public static IContactsSelector newElevatedInstance()
	{
		return (IContactsSelector)
				((fflib_SObjectSelector) Application.Selector.newInstance(Schema.Contact.SObjectType))
						.setDataAccess(fflib_SObjectSelector.DataAccess.SYSTEM_MODE);
	}

	public ContactsSelector()
	{
		super();
	}

	/**
	 * Holds a list of fields to be returned by all selectors methods
	 *
	 * @return Returns list of default Contact fields
	 */
	public virtual List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id,
				Contact.AccountId,
				Contact.BirthDate,
				Contact.DoNotCall,
				Contact.Email,
				Contact.HasOptedOutOfEmail,
				Contact.FirstName,
				Contact.LastName
		};
	}

	public virtual List<Schema.SObjectField> getSObjectPartnerFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id,
				Contact.AccountId,
				Contact.AssistantName,
				Contact.AssistantPhone,
				Contact.Email,
				Contact.FirstName,
				Contact.LastName,
				Contact.ReportsToId,
				Contact.Title
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Contact.SObjectType;
	}

	public virtual List<Contact> selectById(Set<Id> idSet)
	{
		return (List<Contact>) newQueryFactory().setCondition('id in :idSet').toSOQL();
	}


	/**
	 * Query Contact records with the given Account Ids
	 *
	 * @param accountIds The Account Ids to query
	 *
	 * @return Returns the records containing the given Account Id values
	 *
	 * @example
	 *     List<Contact> records = ContactsSelector().newInstance()
	 *                                .selectByAccountId( accountIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE AccountId IN :accountIds
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByAccountId(Set<Id> accountIds)
	{
		return (List<Contact>)
				Database.query(
						newQueryFactory()
								.setCondition('AccountId IN :accountIds')
								.toSOQL()
				);
	}

	/**
	 * Query Contact records with the given LeadSource values
	 * and includes the Account.Name field
	 *
	 * @param leadSources The LeadSource values to query
	 *
	 * @return Returns the records containing the given LeadSource values including the Account Name field
	 *
	 * @example
	 *
	 * Set<String> leadSources = new Set<String>{ 'Email' }
	 * List<Contact> records = ContactsSelector().newInstance()
	 *                                .selectByLeadSource( leadSources );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT Account.Name,
	 *        AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE LeadSource IN :leadSources
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByLeadSource(Set<String> leadSources)
	{
		return (List<Contact>)
				Database.query(
						newQueryFactory()
								.selectField('Account.Name')
								.setCondition('LeadSource IN :leadSources')
								.toSOQL()
				);
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes all the default Account fields
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id which include all the default Account fields
	 *
	 * @example
	 *     ContactsSelector.newInstance()
	 *             .selectByIdWithAccount( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT Account.AccountNumber, Account.Id, Account.Name, Account.Rating, Account.ShippingCountry,
	 *        AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE Id in :idSet
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByIdWithAccount(Set<Id> idSet)
	{
		fflib_QueryFactory queryFactory = newQueryFactory();

		((fflib_SObjectSelector) AccountsSelector.newInstance())
				.configureQueryFactoryFields(
				queryFactory,
				Contact.AccountId.getDescribe().getRelationshipName());

		return Database.query(queryFactory.setCondition('Id in :idSet').toSOQL());
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes all the related Case records
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id with related Case records
	 *
	 * @example
	 *  ContactsSelector.newInstance()
	 *             .selectByIdWithCases( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, Birthdate, DoNotCall, Email, FirstName, HasOptedOutOfEmail, Id, LastName,
	 *       (SELECT CaseNumber, Id, Priority, Status, Subject FROM Cases WHERE Status = 'New' ORDER BY CaseNumber ASC NULLS FIRST )
	 * FROM Contact
	 * WHERE Id in :idSet
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByIdWithCases(Set<Id> idSet)
	{
		fflib_QueryFactory queryFactory = newQueryFactory();

		((fflib_SObjectSelector) CasesSelector.newInstance())
				.addQueryFactorySubselect(
				queryFactory,
				'Cases'
		)
				.setCondition('Status = \'New\'');

		String query = queryFactory.setCondition('Id in :idSet').toSOQL();
		System.debug(query);
		return (List<Contact>) Database.query(query);
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes not the standard fields but the partner fields
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id which contain the partner fields.
	 *
	 * @example
	 *  ContactsSelector.newInstance()
	 *             .selectPartnersById( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, AssistantName, AssistantPhone, Email, FirstName, Id, LastName, ReportsToId, Title
	 * FROM Contact
	 * WHERE Id in :idSet AND RecordType.Name='Partner'
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<PartnerContact> selectPartnersById(Set<Id> idSet)
	{
		List<Contact> result = (List<Contact>) Database.query(
				newQueryFactory(false)
						.selectFields(getSObjectPartnerFieldList())
						.setCondition('Id in :idSet AND RecordType.Name=\'Partner\'')
						.toSOQL()
		);

		return ContactsFactory.generatePartnerContacts(result);
	}
}