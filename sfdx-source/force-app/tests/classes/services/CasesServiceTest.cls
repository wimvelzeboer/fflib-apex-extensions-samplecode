/**
 * File Name: CasesServiceTest
 *
 * @author architect ir. Wilhelmus G.J. Velzeboer
 *
 * Copyright (c), W.G.J. Velzeboer,
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above author notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the author nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
@IsTest
private class CasesServiceTest
{
	@IsTest
	private static void testCaseReopen_IntegratedTest()
	{
		// GIVEN two case records
		List<Case> records = new List<Case>
		{
				new Case(Subject = 'Test A', Status = 'Closed'),
				new Case(Subject = 'Test B', Status = 'Closed')
		};
		insert records;
		Set<Id> caseIds = new Map<Id, SObject>(records).keySet();

		// WHEN we reOpen the cases
		System.Test.startTest();
		CasesService.reOpen(caseIds);
		System.Test.stopTest();

		// THEN the case Status should be changed into 'New'
		List<Case> results = [SELECT Id, Subject, Status FROM Case];
		System.assertEquals(2, results.size());
		for (Integer i = 0; i < results.size(); i++)
		{
			System.assertEquals(
					'New',
					results.get(i).Status,
					'Status should be New for case with subject ' + results.get(i).Subject);
		}
	}

	@IsTest
	static void testCaseReopen_Mocking()
	{
		// GIVEN Two Case Ids
		final Id caseIdA = fflib_IDGenerator.generate(Schema.Case.SObjectType);
		final Id caseIdB = fflib_IDGenerator.generate(Schema.Case.SObjectType);
		final Set<Id> caseIds = new Set<Id> {caseIdA, caseIdB};

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_SObjectUnitOfWork mockUow = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
		Application.UnitOfWork.setMock(mockUow);

		// WHEN we reOpen the cases
		System.Test.startTest();
		CasesService.reOpen(caseIds);
		System.Test.stopTest();

		// THEN the case Status should be changed into 'New'
		((fflib_SObjectUnitOfWork)
				mocks.verify(mockUow,
						mocks
								.times(1)
								.description('Cases should have been send to the UnitOfWork'))
		)
				.registerDirty(
				fflib_Match.sObjectsWith(
						new List<Map<SObjectField, Object>>
						{
								new Map<SObjectField, Object>
								{
										Schema.Case.Id => caseIdA,
										Schema.Case.Status => 'New'
								},
								new Map<SObjectField, Object>
								{
										Schema.Case.Id => caseIdB,
										Schema.Case.Status => 'New'
								}
						}));

		((fflib_SObjectUnitOfWork)
				mocks.verify(mockUow, mocks
						.times(1)
						.description('Cases should have been committed to the Database'))
		)
				.commitWork();
	}

	@IsTest
	static void testCaseReopen_Mocking2()
	{
		// GIVEN Two Case Ids
		final Id caseIdA = fflib_IDGenerator.generate(Schema.Case.SObjectType);
		final Id caseIdB = fflib_IDGenerator.generate(Schema.Case.SObjectType);
		final Set<Id> caseIds = new Set<Id> {caseIdA, caseIdB};

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_SObjectUnitOfWork mockUow = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
		Application.UnitOfWork.setMock(mockUow);

		// WHEN we reOpen the cases
		System.Test.startTest();
		CasesService.reOpen(caseIds);
		System.Test.stopTest();

		// THEN the case Status should be changed into 'New'

		// Match against any object
		((fflib_SObjectUnitOfWork) mocks.verify(mockUow))
				.registerDirty((List<Case>) fflib_Match.anyObject());

		// Capture the actual arguments
		fflib_ArgumentCaptor argument = fflib_ArgumentCaptor.forClass(fflib_ISObjectUnitOfWork.class);
		((fflib_ISObjectUnitOfWork) mocks.verify(mockUow))
				.registerDirty((List<Case>) argument.capture());

		// get all arguments if there were multiple calls to the method

		List<Object> resultAllCalls = argument.getAllValues();
		System.debug('Results:'+resultAllCalls);

		// get arguments of the first call to the method
		Map<Id, Case> resultsById = new Map<Id, Case>((List<Case>) argument.getValue());
		System.assertEquals('New', resultsById.get(caseIdA).Status, 'Case A should have status "New"');
		System.assertEquals('New', resultsById.get(caseIdB).Status, 'Case B should have status "New"');

		((fflib_SObjectUnitOfWork) mocks.verify(mockUow, 1))
				.commitWork();
	}
}