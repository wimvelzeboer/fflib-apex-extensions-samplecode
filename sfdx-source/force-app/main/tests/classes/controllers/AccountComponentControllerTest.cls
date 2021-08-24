/**
 * File Name: AccountComponentControllerTest 
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
private class AccountComponentControllerTest
{
	private static final String WARM = 'Warm';

	@IsTest
	static void testGetterBehavior()
	{
        // GIVEN an Id and a matching record with a 'Warm' Rating
		Id accountId = fflib_IDGenerator.generate(Account.SObjectType);
		String recordId = (String) accountId;

		Account record = new Account(Id = accountId, Rating = WARM);
		IAccounts domain = Accounts.newInstance(new List<Account>{ record });

		Application.Domain.setMock(domain);

		// WHEN - we try to get the rating value for the record with the provided Id
		System.Test.startTest();
		String result = AccountComponentController.getRating(recordId);
		System.Test.stopTest();

        // THEN - the return should be 'Warm'
		System.assertEquals(WARM, result);
	}

	@IsTest
	static void testGetterBehavior_CaptureException()
	{
        // GIVEN - we have an invalid record Id
		String recordId = 'InvalidIdString';

		// WHEN - we try to get the rating that that recordId
		System.Test.startTest();
		Boolean exceptionThrown = false;
		try
		{
			// No need to capture the return value, just execute the logic
			AccountComponentController.getRating(recordId);
		}
		catch (AuraHandledException e)
		{
			exceptionThrown = true;
		}
		System.Test.stopTest();

        // THEN - an exception should have been thrown
		System.assert(exceptionThrown, 'Expected an AuraHandled Exception');
	}

	@IsTest
	static void testGetterBehavior_IdDoesNotExist()
	{
		// GIVEN an Id of a record that does not exist
		Id accountId = fflib_IDGenerator.generate(Account.SObjectType);
		String recordId = (String) accountId;

		IAccounts domain = Accounts.newInstance(new List<Account>());
		Application.Domain.setMock(domain);

		// WHEN - we try to get the rating that that non-existing recordId
		System.Test.startTest();
		Boolean exceptionThrown = false;
		try
		{
			// No need to capture the return value, just execute the logic
			AccountComponentController.getRating(recordId);
		}
		catch (AuraHandledException e)
		{
			exceptionThrown = true;
		}
		System.Test.stopTest();

        // THEN - an exception should have been thrown
		System.assert(exceptionThrown, 'Expected an AuraHandled Exception');
	}

	@IsTest
	static void testSetterBehavior()
	{
		// GIVEN an Id and a matching record with a 'Warm' Rating
		Id accountId = fflib_IDGenerator.generate(Account.SObjectType);
		String recordId = (String) accountId;

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IAccountsService serviceMock = (IAccountsService) mocks.mock(IAccountsService.class);
		Application.Service.setMock(IAccountsService.class, serviceMock);

		// WHEN - we try to set the rating value for the record with the provided Id
		System.Test.startTest();
		AccountComponentController.setWarmRating(recordId);
		System.Test.stopTest();

		// THEN - the service method should be invoked;
		((IAccountsService) mocks.verify(serviceMock)).setRating(new Set<Id>{ accountId }, WARM);
	}

	@IsTest
	static void testSetterBehavior_CaptureException()
	{
		// GIVEN - we have an invalid record Id
		String recordId = 'InvalidIdString';

		// WHEN - we try to get the rating that that recordId
		System.Test.startTest();
		Boolean exceptionThrown = false;
		try
		{
			// No need to capture the return value, just execute the logic
			AccountComponentController.setWarmRating(recordId);
		}
		catch (AuraHandledException e)
		{
			exceptionThrown = true;
		}
		System.Test.stopTest();

		// THEN - an exception should have been thrown
		System.assert(exceptionThrown, 'Expected an AuraHandled Exception');
	}

	@IsTest
	static void testActionBehavior()
	{
		// GIVEN an Id and a matching record with a 'Warm' Rating
		Id accountId = fflib_IDGenerator.generate(Account.SObjectType);
		String recordId = (String) accountId;

		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IAccountsService serviceMock = (IAccountsService) mocks.mock(IAccountsService.class);
		Application.Service.setMock(IAccountsService.class, serviceMock);

		// WHEN - we try to set the rating value for the record with the provided Id
		System.Test.startTest();
		AccountComponentController.recalculateRating(recordId);
		System.Test.stopTest();

		// THEN - the service method should be invoked;
		((IAccountsService) mocks.verify(serviceMock)).recalculateRating(new Set<Id>{ accountId });
	}


	@IsTest
	static void testActionBehavior_CaptureException()
	{
		// GIVEN - we have an invalid record Id
		String recordId = 'InvalidIdString';

		// WHEN - we try to get the rating that that recordId
		System.Test.startTest();
		Boolean exceptionThrown = false;
		try
		{
			// No need to capture the return value, just execute the logic
			AccountComponentController.recalculateRating(recordId);
		}
		catch (AuraHandledException e)
		{
			exceptionThrown = true;
		}
		System.Test.stopTest();

		// THEN - an exception should have been thrown
		System.assert(exceptionThrown, 'Expected an AuraHandled Exception');
	}
}