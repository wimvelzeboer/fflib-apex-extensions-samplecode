public interface ICasesService
{
	void reOpen(Set<Id> caseIds);
	void reOpen(fflib_ISObjectUnitOfWork unitOfWork, Set<Id> caseIds);
}