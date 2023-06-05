/**
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
public inherited sharing class Cases
		extends fflib_SObjects2
		implements ICases
{
	public static ICases newInstance(List<Case> records)
	{
		return (ICases) Application.Domain.newInstance(records, Schema.Case.SObjectType);
	}

	public static ICases newInstance(Set<Id> ids)
	{
		return (ICases) Application.Domain.newInstance(ids);
	}

	public Cases(List<Case> records)
	{
		super(records, Schema.Case.SObjectType);
	}

	public List<Case> getCases()
	{
		return (List<Case>) getRecords();
	}

	public ICases selectById(Set<Id> ids)
	{
		return new Cases(getRecords(ids));
	}

	public ICases setStatus(String status)
	{
		setFieldValue(Case.Status, status);
		return this;
	}

	private ICases selectBy(fflib_Criteria criteria)
	{
		return new Cases(getRecords(criteria));
	}

	private ICases selectBlank(Schema.SObjectField sObjectField)
	{
		List<Case> result = new List<Case>();
		for (Case record : getCases())
		{
			if (String.isNotBlank((String) record.get(sObjectField))) continue;

			result.add(record);
		}
		return new Cases(result);
	}

	private ICases selectNonBlank(Schema.SObjectField sObjectField)
	{
		List<Case> result = new List<Case>();
		for (Case record : getCases())
		{
			if (String.isBlank((String) record.get(sObjectField))) continue;

			result.add(record);
		}
		return new Cases(result);
	}

	private ICases selectNull(Schema.SObjectField sObjectField)
	{
		List<Case> result = new List<Case>();
		for (Case record : getCases())
		{
			if (record.get(sObjectField) != null) continue;

			result.add(record);
		}
		return new Cases(result);
	}

	private ICases selectWith(Schema.SObjectField sObjectField)
	{
		List<Case> result = new List<Case>();
		for (Case record : getCases())
		{
			if (record.get(sObjectField) == null) continue;

			result.add(record);
		}
		return new Cases(result);
	}

	private ICases selectWithout(Schema.SObjectField sObjectField)
	{
		List<Case> result = new List<Case>();
		for (Case record : getCases())
		{
			if (record.get(sObjectField) != null) continue;

			result.add(record);
		}
		return new Cases(result);
	}

	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_SObjects construct(List<Object> records)
		{
			return new Cases((List<SObject>) records);
		}
	}
}
