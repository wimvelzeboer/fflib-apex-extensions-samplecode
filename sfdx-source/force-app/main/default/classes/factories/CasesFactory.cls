public with sharing class CasesFactory
{
	public static List<Case> generateCases(Set<Id> caseIds)
	{
		return factory().generateCases(caseIds);
	}

	private static ICasesFactory factory()
	{
		return (ICasesFactory) Application.Factory.newInstance(ICasesFactory.class);
	}
}