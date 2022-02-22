/**
 * File Name: AccountsTest 
 * Description: 
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
private class AccountsTest
{
	@IsTest
	static void itShouldGetTheShippingCountryValues()
	{
		// GIVEN a domain with accounts containing ShippingCountry values
		Accounts domain = new Accounts(
				new List<Account>
				{
						new Account(ShippingCountry = 'USA', Id = fflib_IDGenerator.generate(Account.SObjectType)),
						new Account(ShippingCountry = 'Ireland', Id = fflib_IDGenerator.generate(Account.SObjectType)),
						new Account(ShippingCountry = '', Id = fflib_IDGenerator.generate(Account.SObjectType)),
						new Account(ShippingCountry = 'Holland', Id = fflib_IDGenerator.generate(Account.SObjectType))
				});

		// WHEN we get the ShippingCountry values for the domain
		System.Test.startTest();
		Map<Id, String> result = domain.getShippingCountryById();
		System.Test.stopTest();

		// THEN the values should be returned
		System.debug('result:'+result);
		System.assertEquals(3, result.size());
		System.assert(new Set<String>(result.values()).containsAll(
						new Set<String> {'USA', 'Ireland', 'Holland'}
				)
		);
	}

	@IsTest
	static void itShouldSetTheRatingField()
	{
		// GIVEN a domain with a few records with no rating
		final String value = 'Hot';
		IAccounts domain = new Accounts(
				new List<Account>
				{
						new Account(),
						new Account()
				});

		// WHEN we set the rating to a value
		System.Test.startTest();
		domain.setRating(value);
		System.Test.stopTest();

		// THEN the rating should have the value
		List<Account> results = domain.getAccounts();
		System.assert(results.size() > 0);
		for (Account result : results)
		{
			System.assertEquals(value, result.Rating);
		}
	}

	@IsTest
	static void itShouldSelectByNumberOfEmployeesGreaterThan()
	{
		// GIVEN a domain with a few records with a value set for NumberOfEmployees
		IAccounts domain = new Accounts(
				new List<Account>
				{
						new Account(NumberOfEmployees = 1),
						new Account(NumberOfEmployees = 2),
						new Account(NumberOfEmployees = 3),
						new Account(NumberOfEmployees = 4),
						new Account(NumberOfEmployees = 5)
				});

		// WHEN we select the accounts with more than 3 employees
		System.Test.startTest();
		List<Account> results = domain.selectByNumberOfEmployeesGreaterThan(3)
				.getAccounts();
		System.Test.stopTest();

		// THEN we should have one record returned
		System.assert(results.size() == 2);
		for (Account result : results)
		{
			System.assert(result.NumberOfEmployees > 2);
		}
	}
}