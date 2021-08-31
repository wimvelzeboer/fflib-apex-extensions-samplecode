/**
 * File Name: MyWebService
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
@RestResource(UrlMapping='/AccountRating/v1.0/*')
global with sharing class AccountRatingWebService
{
	private static final SObjectType ACCOUNT_SOBJECT_TYPE = Schema.Account.SObjectType;
	private static final String CRUD_ERROR_MESSAGE = 'Not Authorised to access Accounts';
	private static final String FLS_ERROR_MESSAGE = 'Not Authorised to access Account Rating data';
	private static final String INVALID_FORMATTED_REQUEST = 'Invalid formatted request';
	private static final String UNHANDLED_EXCEPTION_OCCURRED = 'Unhandled exception occurred';

	/**
	 * Gets the account rating for the given account Id
	 */
	@HttpGet
	global static void doGet()
	{
		try
		{
			// Retrieve sanitised request body
			GetRequestBody request = getGetRequestBody();

			// Validate that the user has the proper access
			fflib_SecurityUtils.checkObjectIsReadable(ACCOUNT_SOBJECT_TYPE);
			fflib_SecurityUtils.checkFieldIsReadable(ACCOUNT_SOBJECT_TYPE, Schema.Account.Rating);

			// Get the required data
			IAccounts accounts = Accounts.newInstance(request.AccountIds);

			// Translate, filter and return the data
			RestContext.response.responseBody = new GetResponseBody(accounts).toBlob();
			RestContext.response.statusCode = 200;
		}
		// Unauthorised to SObject
		catch (fflib_SecurityUtils.CrudException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(CRUD_ERROR_MESSAGE).toBlob();
		}
		// Unauthorised to Field
		catch (fflib_SecurityUtils.FlsException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(FLS_ERROR_MESSAGE).toBlob();
		}
		// JSON formatting error
		catch (System.JSONException e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(INVALID_FORMATTED_REQUEST).toBlob();
		}
		catch (Exception e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(UNHANDLED_EXCEPTION_OCCURRED).toBlob();
		}
	}

	/**
	 * Put request update an existing record
	 */
	@HttpPut
	global static void doPut()
	{
		try
		{
			// Retrieve sanitised request body
			PutRequestBody request = getPutRequestBody();

			// Validate that the user has the proper access
			fflib_SecurityUtils.checkObjectIsReadable(ACCOUNT_SOBJECT_TYPE);
			fflib_SecurityUtils.checkFieldIsReadable(ACCOUNT_SOBJECT_TYPE, Schema.Account.Rating);

			// Retrieve the records and update the fields
			IAccounts accounts = Accounts.newInstance(request.getAccountIds());
			accounts.setRatingById(request.getRatingById());

			// Send changes to the database
			fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance(
					new List<SObjectType>{ Account.SObjectType}
			);
			unitOfWork.registerDirty(accounts.getRecords());
			unitOfWork.commitWork();

			// Return a success response
			RestContext.response.statusCode = 200;
		}
		// Unauthorised to SObject
		catch (fflib_SecurityUtils.CrudException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(CRUD_ERROR_MESSAGE).toBlob();
		}
		// Unauthorised to Field
		catch (fflib_SecurityUtils.FlsException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(FLS_ERROR_MESSAGE).toBlob();
		}
		// JSON formatting error
		catch (System.JSONException e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(INVALID_FORMATTED_REQUEST).toBlob();
		}
		catch (Exception e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(e.getMessage()).toBlob();
		}
	}

	/**
	 * Delete request to remove Rating data from existing records
	 */
	@HttpDelete
	global static void doDelete()
	{
		try
		{
			// Retrieve sanitised request body
			DeleteRequestBody request = getDeleteRequestBody();

			// Validate that the user has the proper access
			fflib_SecurityUtils.checkObjectIsReadable(ACCOUNT_SOBJECT_TYPE);
			fflib_SecurityUtils.checkFieldIsReadable(ACCOUNT_SOBJECT_TYPE, Schema.Account.Rating);

			// Retrieve the records and update the fields
			IAccounts accounts = Accounts.newInstance(request.accountIds);
			accounts.setRating(null);

			// Send changes to the database
			fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance(
					new List<SObjectType>{ Account.SObjectType}
			);
			unitOfWork.registerDirty(accounts.getRecords());
			unitOfWork.commitWork();

			// Return a success response
			RestContext.response.statusCode = 200;
		}
		// Unauthorised to SObject
		catch (fflib_SecurityUtils.CrudException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(CRUD_ERROR_MESSAGE).toBlob();
		}
		// Unauthorised to Field
		catch (fflib_SecurityUtils.FlsException e)
		{
			RestContext.response.statusCode = 401;
			RestContext.response.responseBody = new ErrorResponse(FLS_ERROR_MESSAGE).toBlob();
		}
		// JSON formatting error
		catch (System.JSONException e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(INVALID_FORMATTED_REQUEST).toBlob();
		}
		catch (Exception e)
		{
			RestContext.response.statusCode = 400;
			RestContext.response.responseBody = new ErrorResponse(e.getMessage()).toBlob();
		}
	}

	private static DeleteRequestBody getDeleteRequestBody()
	{
		try
		{
			RestRequest restRequest = RestContext.request;
			return (DeleteRequestBody) JSON.deserialize(restRequest.requestBody.toString(), DeleteRequestBody.class);
		}
		catch (Exception e)
		{
			// Maybe add here some extra error logging to capture the stack-trace.
			throw new DeveloperException('Unable to process request body: ' + e.getMessage());
		}
	}

	private static GetRequestBody getGetRequestBody()
	{
		try
		{
			RestRequest restRequest = RestContext.request;
			return (GetRequestBody) JSON.deserialize(restRequest.requestBody.toString(), GetRequestBody.class);
		}
		catch (Exception e)
		{
			// Maybe add here some extra error logging to capture the stack-trace.
			throw new DeveloperException('Unable to process request body: ' + e.getMessage());
		}
	}

	private static PutRequestBody getPutRequestBody()
	{
		try
		{
			// Get the REST Request
			RestRequest restRequest = RestContext.request;

			// Convert it to the data type PutRequestBody
			AccountRatingWebService.PutRequestBody requestBody =
					(PutRequestBody) JSON.deserialize(restRequest.requestBody.toString(), PutRequestBody.class);

			// Sanitised the data to prevent hacks
			requestBody.sanitise();

			// Return the clean and valid data
			return requestBody;
		}
		catch (Exception e)
		{
			// Maybe add here some extra error logging to capture the stack-trace.
			throw new DeveloperException('Unable to process request body: ' + e.getMessage());
		}
	}

	public virtual class AccountIdsInfo
	{
		public Set<Id> AccountIds { get; set; }
	}

	public class GetRequestBody extends AccountIdsInfo {}
	public class DeleteRequestBody extends AccountIdsInfo {}

	global virtual class AccountRatingInfo
	{
		public List<AccountRating> AccountRatings { get; set; }

		public AccountRatingInfo(IAccounts accounts)
		{
			this.AccountRatings = new List<AccountRating>();
			for (Account record : accounts.getAccounts())
			{
				this.AccountRatings.add(
						new AccountRating(record)
				);
			}
		}

		public void sanitise()
		{
			for (AccountRating record : AccountRatings)
			{
				record.sanitise();
			}
		}

		public Blob toBlob()
		{
			return Blob.valueOf(JSON.serialize(this));
		}
	}

	global class GetResponseBody extends AccountRatingInfo
	{
		public GetResponseBody(IAccounts accounts)
		{
			super(accounts);
		}
	}


	global class PutRequestBody extends AccountRatingInfo
	{
		public PutRequestBody(IAccounts accounts)
		{
			super(accounts);
		}

		public Set<Id> getAccountIds()
		{
			Set<Id> result = new Set<Id>();
			for (AccountRating record : AccountRatings)
			{
				result.add(record.AccountId);
			}
			return result;
		}

		public Map<Id, String> getRatingById()
		{
			Map<Id, String> result = new Map<Id, String>();
			for (AccountRating record : AccountRatings)
			{
				result.put(record.AccountId, record.Rating);
			}
			return result;
		}
	}

	private class AccountRating
	{
		public Id AccountId { get; set; }
		public String Rating { get; set; }

		public AccountRating(Account record)
		{
			this.AccountId = record.Id;
			this.Rating = record.Rating;
		}

		public void sanitise()
		{
			this.Rating = String.escapeSingleQuotes(this.Rating);
		}
	}

	public class ErrorResponse
	{
		public String ErrorMessage { get; set; }

		public ErrorResponse(String message)
		{
			this.ErrorMessage = message;
		}

		public Blob toBlob()
		{
			return Blob.valueOf(JSON.serialize(this));
		}
	}

	public class DeveloperException extends Exception {}
}