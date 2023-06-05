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
public with sharing class Application
{
	private static fflib_IAppBindingResolver bindingResolver = new fflib_AppBindingResolver();

	public static final fflib_ClassicUnitOfWorkFactory UnitOfWork =
			new fflib_ClassicUnitOfWorkFactory(
					new List<SObjectType>
					{
							Schema.Account.SObjectType,
							Schema.Contact.SObjectType,
							Schema.Case.SObjectType
					}
			);

	public static final fflib_DynamicServiceFactory Service =
			new fflib_DynamicServiceFactory(bindingResolver)
					.setSharingMode(fflib_SharingMode.WithSharing);

	public static final fflib_DynamicSelectorFactory Selector =
			new fflib_DynamicSelectorFactory(bindingResolver);

	public static final fflib_DynamicSelectorFactory ElevatedSelector =
			new fflib_DynamicSelectorFactory(bindingResolver)
					.setSharingMode(fflib_SharingMode.WithoutSharing);

	public static final fflib_DynamicSelectorFactory NoSharingSelector =
			new fflib_DynamicSelectorFactory(bindingResolver)
					.setSharingMode(fflib_SharingMode.InheritedSharing);

	public static final fflib_DynamicDomainFactory Domain =
			new fflib_DynamicDomainFactory(bindingResolver, Selector);

	public static final fflib_ClassicServiceFactory Factory =
			new fflib_ClassicServiceFactory(
					new Map<Type, Type>
					{
							ICasesFactory.class => CasesFactoryImpl.class,
							IContactsFactory.class => ContactsFactoryImpl.class
					}
			);

	public static final fflib_ILogger Log = new fflib_Logger()
			.addAppender(new fflib_LogEventAppender());
}