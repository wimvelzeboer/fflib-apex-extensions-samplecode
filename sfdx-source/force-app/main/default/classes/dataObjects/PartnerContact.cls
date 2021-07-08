/**
 * File Name: PartnerContact
 * Description: Data class for Partner Contact data
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
public with sharing class PartnerContact
{
	private Contact record;

	public Id recordId
	{
		get
		{
			return this.record.Id;
		}
		set
		{
			this.record.Id = value;
		}
	}

	public Id accountId
	{
		get
		{
			return this.record.AccountId;
		}
		set
		{
			this.record.Id = value;
		}
	}

	public String assistantName
	{
		get
		{
			return this.record.AssistantName;
		}
		set
		{
			this.record.AssistantName = value;
		}
	}

	public String assistantPhone
	{
		get
		{
			return this.record.AssistantPhone;
		}
		set
		{
			this.record.AssistantPhone = value;
		}
	}

	public String email
	{
		get
		{
			return this.record.Email;
		}
		set
		{
			this.record.Email = value;
		}
	}

	public String firstName
	{
		get
		{
			return this.record.FirstName;
		}
		set
		{
			this.record.FirstName = value;
		}
	}

	public String lastName
	{
		get
		{
			return this.record.LastName;
		}
		set
		{
			this.record.LastName = value;
		}
	}

	public Id reportsToId
	{
		get
		{
			return this.record.ReportsToId;
		}
		set
		{
			this.record.ReportsToId = value;
		}
	}

	public String title
	{
		get
		{
			return this.record.Title;
		}
		set
		{
			this.record.Title = value;
		}
	}

	public PartnerContact(Contact record)
	{
		this.record = record;
	}
}