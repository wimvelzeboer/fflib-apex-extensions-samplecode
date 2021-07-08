/**
 * File Name: AccountsTriggerHandlerTest 
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
private class AccountsTriggerHandlerTest
{
	@IsTest
	static void testRecordCreation()
	{
        // GIVEN
        List<Account> testData = new List<Account>();
        testData.addAll(generateRecalculateRatingTestData());
        //testData.addAll(generate......TestData());
        //testData.addAll(generate......TestData());
        //...
        final Integer amount = testData.size();

        // WHEN the test data is created
        System.Test.startTest();
        insert testData;
        System.Test.stopTest();

        // THEN it should be created as expected
        Set<Id> recordIds = new Map<Id, SObject>(testData).keySet();
        List<Account> result = AccountsSelector.newInstance().selectById(recordIds);
        System.assertEquals(amount, result.size());
        verifyRecalculateRatingData(result);
        //verify.....Data(result);
        //verify.....Data(result);
        //..
	}

    private static void verifyRecalculateRatingData(List<Account> accounts)
    {
        for (Account record : accounts)
        {
            if (record.NumberOfEmployees > 99 && record.Rating != 'Hot')
                throw new RecalculateRatingException('Expected Hot rating for accounts with more than 99 employees');

            else if (record.NumberOfEmployees < 100 && record.Rating != 'Warm')
                throw new RecalculateRatingException('Expected Warm rating for accounts with less than 100 employees');
        }
    }

    private static List<Account> generateRecalculateRatingTestData()
    {
        return new List<Account>
        {
                new Account(Name = 'TestRating', Rating = 'Cold', NumberOfEmployees = 50),
                new Account(Name = 'TestRating', Rating = 'Cold', NumberOfEmployees = 500)
        };
    }

    public class RecalculateRatingException extends Exception {}
}