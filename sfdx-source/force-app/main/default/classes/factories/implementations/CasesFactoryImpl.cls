public inherited sharing class CasesFactoryImpl
		extends fflib_SObjectFactory
		implements ICasesFactory
{
	public List<Case> generateCases(Set<Id> caseIds)
	{
		return (List<Case>) generateSObjectById(caseIds);
	}

	public Schema.SObjectType getSObjectType()
	{
		return Schema.Case.SObjectType;
	}
}