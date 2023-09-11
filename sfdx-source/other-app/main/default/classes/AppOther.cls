/**
 * File Name: Application
 * Description: generates instances of the application components
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
public with sharing class AppOther
{
	public final static String NAME = 'other_app';

	public final static List<SObjectType> UNIT_OF_WORK_HIERARCHY = new List<SObjectType>
	{
			Schema.Account.SObjectType,
			Schema.Contact.SObjectType,
			Schema.Case.SObjectType
	};

	public static final fflib_ClassicUnitOfWorkFactory UnitOfWork =
			new fflib_ClassicUnitOfWorkFactory(UNIT_OF_WORK_HIERARCHY);

	public static final fflib_DynamicServiceFactory Service =
			new fflib_DynamicServiceFactory(Application.bindingResolver, NAME);

	public static final fflib_DynamicSelectorFactory Selector =
			new fflib_DynamicSelectorFactory(Application.bindingResolver, NAME);

	public static final fflib_DynamicDomainFactory Domain =
			new fflib_DynamicDomainFactory(Application.bindingResolver,	Selector, NAME);
}