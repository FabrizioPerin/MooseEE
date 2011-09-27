Class {
	#name : #FAMIXClassGroupMJExtensionTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #tests }
FAMIXClassGroupMJExtensionTests >> testGroupClassesConsiderInvokationHierarchy [
	| mooseModel max aStatelessSessionBean aStatefulSessionBean class3 class4 |
	
	max := 0.
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.
	
	mooseModel allClasses groupClassesConsiderInvokationHierarchy.
	self assert: (mooseModel allClasses select: [ :class | class groupNumber isNil ]) isEmpty.

	aStatelessSessionBean := (mooseModel allClasses select: [:class | class name = 'AStatelessSessionBean']) first.
	aStatefulSessionBean := (mooseModel allClasses select: [:class | class name = 'AStatefulSessionBean']) first.
	class3 := (mooseModel allClasses select: [:class | class name = 'Class3']) first.
	class4 := (mooseModel allClasses select: [:class | class name = 'Class4']) first.
	self assert: ( (aStatelessSessionBean groupNumber = aStatefulSessionBean groupNumber) and: [
				(aStatefulSessionBean groupNumber = class3 groupNumber) and: [
				(class3 groupNumber = class4 groupNumber) ]]	).
	
	mooseModel allClasses do: [ :class | max := class groupNumber max: max ].
	self assert: max = 14
]

{ #category : #tests }
FAMIXClassGroupMJExtensionTests >> testRationNOQMNOM [


	| mooseModel  |
	
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #NOQM ) = 3).
	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #WIM) = 19 ).

	self assert: ( mooseModel allClasses RatioNOQMNOM = ( 3.0 / 19.0 )).
]

{ #category : #tests }
FAMIXClassGroupMJExtensionTests >> testRationNOTMNOM [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #NOTM ) = 13).
	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #WIM ) = 19 ).

	self assert: ( mooseModel allClasses RatioNOTMNOM = ( 13.0 / 19.0 )).
]
