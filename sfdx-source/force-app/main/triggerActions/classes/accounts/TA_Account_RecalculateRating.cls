public with sharing class TA_Account_RecalculateRating
		extends fflib_TriggerAction
{
	public override void onBeforeInsert()
	{
		recalculateRating();
	}

	public override void onBeforeUpdate()
	{
		onChangedNumberOfEmployeesRecalculateRating();
	}

	private void onChangedNumberOfEmployeesRecalculateRating()
	{
		List<SObject> changedRecords =
				triggerContext.getChangedRecords(new Set<SObjectField> {Schema.Account.NumberOfEmployees});

		if (changedRecords.isEmpty()) return;

		Accounts.newInstance(changedRecords)
				.recalculateRating();
	}

	private void recalculateRating()
	{
		Accounts.newInstance(triggerContext.getRecords())
				.recalculateRating();
	}
}