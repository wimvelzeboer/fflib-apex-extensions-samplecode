public inherited sharing class ContactsFactoryImpl
		extends fflib_SObjectFactory
		implements IContactsFactory
{
	public List<PartnerContact> generatePartnerContacts(List<Contact> contacts)
	{
		List<PartnerContact> result = new List<PartnerContact>();
		for (Contact record : contacts)
		{
			result.add(
					new PartnerContact(record)
			);
		}
		return result;
	}

	public Schema.SObjectType getSObjectType()
	{
		return Schema.Contact.SObjectType;
	}
}