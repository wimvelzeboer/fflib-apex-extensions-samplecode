@IsTest(IsParallel=true)
private class CasesTest
{
	@IsTest
	static void testNewInstanceWithIds()
	{
		final Id id = fflib_IDGenerator.generate(Schema.Case.SObjectType);
		final Set<Id> ids = new Set<Id> {id};
		final List<Case> records = new List<Case> {new Case(Id = id)};

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		ICasesSelector selectorMock = (ICasesSelector) mocks.mock(ICasesSelector.class);

		mocks.startStubbing();
		mocks.when(selectorMock.selectSObjectsById(ids)).thenReturn(records);
		mocks.stopStubbing();

		Application.Selector.setMock(Schema.Case.SObjectType, selectorMock);

		System.Test.startTest();
		ICases result = Cases.newInstance(ids);
		System.Test.stopTest();

		System.assertEquals(records, result.getCases());
	}

	@IsTest
	static void testNewInstanceWithRecords()
	{
		final List<Case> records = new List<Case> {new Case(Id = fflib_IDGenerator.generate(Schema.Case.SObjectType))};

		System.Test.startTest();
		ICases result = Cases.newInstance(records);
		System.Test.stopTest();

		System.assertEquals(records, result.getCases());
	}
}