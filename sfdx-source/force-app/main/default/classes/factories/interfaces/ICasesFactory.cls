public interface ICasesFactory extends fflib_ISObjectFactory
{
	List<Case> generateCases(Set<Id> caseIds);
}