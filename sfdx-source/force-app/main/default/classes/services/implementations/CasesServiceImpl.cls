public inherited sharing class CasesServiceImpl
		implements ICasesService
{
	public void reOpen(Set<Id> caseIds)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		reOpen(unitOfWork, caseIds);
		unitOfWork.commitWork();
	}

	public void reOpen(fflib_ISObjectUnitOfWork unitOfWork, Set<Id> caseIds)
	{
		List<Case> records = CasesFactory.generateCases(caseIds);
		ICases cases =
				Cases.newInstance(records)
						.setStatus('New');

		unitOfWork.registerDirty(cases.getCases());
	}
}