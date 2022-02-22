/**
 * File Name: CasesSelector
 * Description: Selector implementation for Case records
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
public virtual inherited sharing class CasesSelector
		extends fflib_SObjectSelector
		implements ICasesSelector
{
	public static ICasesSelector newInstance()
	{
		return (ICasesSelector) Application.Selector.newInstance(Schema.Case.SObjectType);
	}

	public static ICasesSelector newWithoutSharingInstance()
	{
		return (ICasesSelector) Application.ElevatedSelector.newInstance(Schema.Case.SObjectType);
	}

	public static ICasesSelector newInheritedSharingInstance()
	{
		return (ICasesSelector) Application.NoSharingSelector.newInstance(Schema.Case.SObjectType);
	}

	public CasesSelector()
	{
		super();
	}

	public CasesSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS)
	{
		super(includeFieldSetFields, enforceCRUD, enforceFLS);
	}

	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Case.Id,
				Case.CaseNumber,
				Case.Priority,
				Case.Status,
				Case.Subject
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Schema.Case.SObjectType;
	}

	public virtual List<Case> selectById(Set<Id> idSet)
	{
		return (List<Case>) selectSObjectsById(idSet);
	}

	public with sharing class WithSharing extends CasesSelector
	{
		// Constructor that will enforce CRUD and FLS
		public WithSharing()
		{
			super(true, true, true);
		}

		public override List<Case> selectById(Set<Id> idSet)
		{
			return super.selectById(idSet);
		}
	}

	public without sharing class WithoutSharing extends CasesSelector
	{
		// Constructor that will enforce CRUD and FLS
		public WithoutSharing()
		{
			super(true, false, false);
		}

		public override List<Case> selectById(Set<Id> idSet)
		{
			return super.selectById(idSet);
		}
	}
}