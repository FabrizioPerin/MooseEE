Class {
	#name : #MJEJBeanElementTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-Tests-EJBDraftObjs'
}

{ #category : #tests }
MJEJBeanElementTests >> minimalEjbJar [

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

{ #category : #setup }
MJEJBeanElementTests >> setUp [
	| parser factory doc |
	parser := XMLDOMParser on: self minimalEjbJar readStream.
	factory := XMLPluggableElementFactory new
				elementClass: MJEJBeanElement;
				handleElement: 'entity' withClass: MJEntityElement;
				handleElement: 'message-driven' withClass: MJMessageDrivenElement;
				handleElement: 'session' withClass: MJSessionElement;
				handleElement: 'container-transaction' withClass: MJContainerTransactionElement.

	parser nodeFactory: factory.  

	doc := parser parseDocument.
	root := doc root.

]

{ #category : #testsOnJEEModel }
MJEJBeanElementTests >> testElementCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJEntityElement ]) size = 2.
	self assert: (root allElements select: [:each | each isMemberOf: MJSessionElement ]) size = 2.
	self assert: (root allElements select: [:each | each isMemberOf: MJContainerTransactionElement ]) size = 3.
	self assert: (root allElements select: [:each | each isMemberOf:  MJMessageDrivenElement ]) size = 1.
]

{ #category : #testsOnJEEModel }
MJEJBeanElementTests >> testEntityResolving [
	
	| mooseModel aBean |
	mooseModel := JEETestModels new sampleMooseModel.

	(root allElements select: [:each | each class = MJEntityElement ]) do: [:each | each populate: mooseModel].

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
MJEJBeanElementTests >> testMessageDrivenResolving [
	
	| mooseModel aBean |
	mooseModel := JEETestModels new sampleMooseModel.

	(root allElements select: [:each | each class = MJMessageDrivenElement]) do: [:each | each populate: mooseModel].

	self assert: mooseModel allMessageDrivenBeans size = 1.
	self assert: (mooseModel allMessageDrivenBeans contains: [:each | each name = #AMessageDriven]).

	aBean := mooseModel allMessageDrivenBeans detect: [:each | each name = #AMessageDriven].
	self assert: aBean homeInterface isNil.
	self assert: aBean remoteInterface isNil.
	self assert: aBean implementationClass notNil.
]

{ #category : #testsOnJEEModel }
MJEJBeanElementTests >> testSessionResolving [
	
	| mooseModel aStateless aStateful |
	
	mooseModel := JEETestModels new sampleMooseModel.
	
	(root allElements select: [:each | each class = MJSessionElement]) do: [:each | each populate: mooseModel].

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
