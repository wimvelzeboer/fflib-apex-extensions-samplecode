public with sharing class ContactsFactory
{
	public static List<PartnerContact> generatePartnerContacts(List<Contact> contacts)
	{
		return factory().generatePartnerContacts(contacts);
	}

	private static IContactsFactory factory()
	{
		return (IContactsFactory) Application.Factory.newInstance(IContactsFactory.class);
	}
}