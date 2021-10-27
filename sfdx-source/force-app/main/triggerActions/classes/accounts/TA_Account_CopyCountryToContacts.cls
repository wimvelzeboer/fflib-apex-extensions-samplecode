public with sharing class TA_Account_CopyCountryToContacts
		extends fflib_TriggerAction
{
	public override void onBeforeUpdate()
	{
		onChangedCountryCopyValueToContacts();
	}

	private void onChangedCountryCopyValueToContacts()
	{
		List<SObject> changedRecords =
				triggerContext.getChangedRecords(new Set<SObjectField> {Schema.Account.ShippingCountry});

		if (changedRecords.isEmpty()) return;

		AccountsService.copyShippingCountryToContacts((List<Account>) changedRecords);
	}
}