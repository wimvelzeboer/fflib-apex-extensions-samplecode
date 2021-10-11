/**
 * File Name: AccountComponentController
 * Description: Lightning Component Controller
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
public with sharing class AccountComponentController
{
	// Getter Method Example
	@AuraEnabled
	public static String getRating(String recordId)
	{
		System.Savepoint savepoint = Database.setSavepoint();
		try
		{
			// Sanitise the input to make sure we have a valid Id
			Id accountId = Id.valueOf(recordId);

			// Assert that the user has access to the Object
			fflib_SecurityUtils.checkObjectIsUpdateable(Schema.Account.SObjectType);

			// Retrieve the record
			IAccounts accounts = Accounts.newInstance(new Set<Id> {accountId});
			assertAccountsIsNotBlank(accounts, recordId);

			// Convert and return the requested value
			return accounts.getRating().getFirst();
		}
		catch (Exception e)
		{
			// Make sure we have database roll-back
			Database.rollback(savepoint);

			// Save a log message
			Application.Log.warning(e.getMessage());

			// Translate the exception to something user friendly
			AuraHandledException auraException = new AuraHandledException(e.getMessage());
			auraException.setMessage(e.getStackTraceString());
			throw auraException;
		}
	}

	// Setter Method Example
	@AuraEnabled
	public static void setWarmRating(String recordId)
	{
		System.Savepoint savepoint = Database.setSavepoint();
		try
		{
			// Sanitise the input to make sure we have a valid Id
			Id accountId = Id.valueOf(recordId);

			// Assert that the user has access to the Object
			fflib_SecurityUtils.checkObjectIsUpdateable(Schema.Account.SObjectType);

			// Invoke service setter method
			AccountsService.setRating(new Set<Id> {accountId}, 'Warm');
		}
		catch (Exception e)
		{
			// Make sure we have database roll-back
			Database.rollback(savepoint);

			// Save a log message
			Application.Log.warning(e.getMessage());

			// Translate the exception to something user friendly
			AuraHandledException auraException = new AuraHandledException(e.getMessage());
			auraException.setMessage(e.getStackTraceString());
			throw auraException;
		}
	}

	@AuraEnabled
	public static void recalculateRating(String recordId)
	{
		System.Savepoint savepoint = Database.setSavepoint();
		try
		{
			// Sanitise the input to make sure we have a valid Id
			Id accountId = Id.valueOf(recordId);

			// Assert that the user has access to the Object
			fflib_SecurityUtils.checkObjectIsUpdateable(Schema.Account.SObjectType);

			// Invoke service method
			AccountsService.recalculateRating(new Set<Id> {accountId});
		}
		catch (Exception e)
		{
			// Make sure we have database roll-back
			Database.rollback(savepoint);

			// Save a log message
			Application.Log.warning(e.getMessage());

			// Translate the exception to something user friendly
			AuraHandledException auraException = new AuraHandledException(e.getMessage());
			auraException.setMessage(e.getStackTraceString());
			throw auraException;
		}
	}

	private static void assertAccountsIsNotBlank(IAccounts accounts, String recordId)
	{
		if (accounts.isNotEmpty()) return;

		throw new InvalidInputException(
				String.format(
						'The provided record Id \'{0}\' does not exists or is not accessible',
						new List<String> {recordId}
				)
		);
	}

	public class InvalidInputException extends Exception {}
}