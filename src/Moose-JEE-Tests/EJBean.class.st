Class {
	#name : #EJBean,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-Tests-Opax'
}

{ #category : #tests }
EJBean >> minimalEjbJar [

	^'<?xml version="1.0"?>
<ejb-jar>

<enterprise-beans>

	<!-- A minimal session EJB deployment -->
	<session>
 		 <ejb-name>AStatefulSession</ejb-name>
		<home>aPackage.AStatefulSessionHome</home>
		<remote>aPackage.AStatefulSession</remote>
		<ejb-class>aPackage.AStatefulSessionBean</ejb-class>
		<session-type>Stateful</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<session>
 		 <ejb-name>AStatelessSession</ejb-name>
		<home>aPackage.AStatelessSessionHome</home>
		<remote>aPackage.AStatelessSession</remote>
		<ejb-class>aPackage.AStatelessSessionBean</ejb-class>
		<session-type>Stateless</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<!-- A minimal CMP entity EJB deployment -->
	<entity>
		<ejb-name>ACMPEntity</ejb-name>
		<home>anotherPackage.ACMPEntityHome</home>
		<remote>anotherPackage.ACMPEntity</remote>
		<ejb-class>anotherPackage.ACMPEntityBean</ejb-class>
		<persistence-type>Container</persistence-type>
		<prim-key-class>anotherPackage.ACMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
		<cmp-field><field-name>attribute1</field-name></cmp-field>
		<cmp-field><field-name>attribute2</field-name></cmp-field>
      </entity>
      
	<!-- A minimal BMP entity EJB deployment -->
	<entity>
		<ejb-name>ABMPEntity</ejb-name>
		<home>anotherPackage.ABMPEntityHome</home>
		<remote>anotherPackage.ABMPEntity</remote>
		<ejb-class>anotherPackage.ABMPEntityBean</ejb-class>
		<persistence-type>Bean</persistence-type>
		<prim-key-class>anotherPackage.ABMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
	</entity>

	<message-driven>
		<ejb-name>AMessageDriven</ejb-name>
		<ejb-class>aPackage.AMessageBean</ejb-class>
		<transaction-type>Container</transaction-type>
		<message-driven-destination>
			<destination-type>
				javax.jms.Topic
			</destination-type>
		</message-driven-destination>
		...
	</message-driven>

</enterprise-beans>

<assembly-descriptor>

	<container-transaction> 
		<method> 
			<ejb-name>AStatefulSession</ejb-name> 
			<method-name>*</method-name> 
		</method> 
		<trans-attribute>Required</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>AStatelessSession</ejb-name> 
			<method-name>aMethod</method-name> 
		</method> 
		<trans-attribute>Mandatory</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>ABMPEntity</ejb-name> 
			<method-name>a*</method-name> 
		</method> 
		<trans-attribute>RequiresNew</trans-attribute> 
	</container-transaction> 

</assembly-descriptor>

</ejb-jar>
'
]

{ #category : #models }
EJBean >> sampleMooseModel [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean |
	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aStatelessSessionBean addMethod: (FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.
	aStatefulSessionBean
			addMethod: (FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;
				yourself
			).

		
	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		add: aPackage;
		add: anotherPackage;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatelessSession;
			container: aPackage;
			yourself
		);
		add: aStatelessSessionBean;
		add: (FAMIXClass new
			name: #AStatefulSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatefulSession;
			container: aPackage;
			yourself
		);
		add: aStatefulSessionBean;
		add: (FAMIXClass new
			name: #ACMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityPK;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AMessageBean;
			container: aPackage;
			yourself
		).


	^mooseModel
]

{ #category : #setup }
EJBean >> setUp [
	| parser |
	parser := OPOpaxHandler on: self minimalEjbJar readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.

]

{ #category : #testsOnJEEModel }
EJBean >> testElementCreation [

	self assert: (root allChildren select: [:each | each isMemberOf: EntityElement ]) size = 2.
	self assert: (root allChildren select: [:each | each isMemberOf: SessionElement ]) size = 2.
	self assert: (root allChildren select: [:each | each isMemberOf: ContainerTransactionElement ]) size = 3.
	self assert: (root allChildren select: [:each | each isMemberOf:  MessageDrivenElement ]) size = 1.
]

{ #category : #testsOnJEEModel }
EJBean >> testEntityResolving [
	
	| mooseModel aBean |
	mooseModel := self sampleMooseModel.

	(root allChildren select: [:each | each class = EntityElement ]) do: [:each | each populate: mooseModel].

	self assert: mooseModel allEntityBeans size = 2.
	self assert: (mooseModel allEntityBeans contains: [:each | each name = #ACMPEntity]).
	self assert: (mooseModel allEntityBeans contains: [:each | each name = #ABMPEntity]).

	aBean := mooseModel allEntityBeans detect: [:each | each name = #ACMPEntity].
	self assert: aBean homeInterface notNil.
	self assert: aBean homeInterface parentEJBBean = aBean.
	self assert: aBean remoteInterface notNil.
	self assert: aBean remoteInterface parentEJBBean = aBean.
	self assert: aBean implementationClass notNil.
	self assert: aBean implementationClass parentEJBBean = aBean.
	self assert: aBean isCMP.
	self assert: aBean primaryKeyClass notNil.

	aBean := mooseModel allEntityBeans detect: [:each | each name = #ABMPEntity].
	self assert: aBean homeInterface notNil.
	self assert: aBean remoteInterface notNil.
	self assert: aBean implementationClass notNil.
	self assert: aBean isBMP.
	self assert: aBean primaryKeyClass isNil.
]

{ #category : #tests }
EJBean >> testMessageDrivenResolving [
	
	| mooseModel aBean |
	mooseModel := self sampleMooseModel.

	(root allChildren select: [:each | each class = MessageDrivenElement]) do: [:each | each populate: mooseModel].

	self assert: mooseModel allMessageDrivenBeans size = 1.
	self assert: (mooseModel allMessageDrivenBeans contains: [:each | each name = #AMessageDriven]).

	aBean := mooseModel allMessageDrivenBeans detect: [:each | each name = #AMessageDriven].
	self assert: aBean homeInterface isNil.
	self assert: aBean remoteInterface isNil.
	self assert: aBean implementationClass notNil.
]

{ #category : #testsOnJEEModel }
EJBean >> testSessionResolving [
	
	| mooseModel aStateless aStateful |
	mooseModel := self sampleMooseModel.
	(root allChildren select: [:each | each class = SessionElement]) do: [:each | each populate: mooseModel].

	self assert: mooseModel allSessionBeans size = 2.
	self assert: (mooseModel allSessionBeans contains: [:each | each name = #AStatelessSession]).
	self assert: (mooseModel allSessionBeans contains: [:each | each name = #AStatefulSession]).

	aStateless := mooseModel allSessionBeans detect: [:each | each name = #AStatelessSession].
	self assert: aStateless remoteInterface notNil.
	self assert: aStateless homeInterface notNil.
	self assert: aStateless implementationClass notNil.
	self assert: aStateless isStateless.

	aStateful := mooseModel allSessionBeans detect: [:each | each name = #AStatefulSession].
	self assert: aStateful remoteInterface notNil.
	self assert: aStateful homeInterface notNil.
	self assert: aStateful implementationClass notNil.
	self assert: aStateful isStateful.
]
