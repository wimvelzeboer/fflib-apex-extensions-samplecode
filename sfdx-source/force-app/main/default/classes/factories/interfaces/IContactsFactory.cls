public interface IContactsFactory extends fflib_ISObjectFactory
{
	List<PartnerContact> generatePartnerContacts(List<Contact> contacts);
}