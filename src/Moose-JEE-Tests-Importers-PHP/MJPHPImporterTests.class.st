Class {
	#name : #MJPHPImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'namespace',
		'namespaceStack',
		'fieldNode',
		'annotations'
	],
	#category : #'Moose-JEE-Tests-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> setUp [
	| parameter parameterTwo parameterThree annotationOne annotationTwo |
	super setUp.
	namespaceStack := PPPHPNamespaceStack createFromCollection: {'\'. 'Vendor'. 'Component'. 'Class'.}.
	namespace :=  namespaceStack top.
	
	fieldNode := PPPHPFieldNode new.
	fieldNode nodeName: 'aField'.
	fieldNode scope: (PPPHPScopeNode new scope: 'protected').
	fieldNode defaultValue: 'array()'.
	fieldNode isStatic: true.
	
	parameter := PPPHPAttributeNode new.
	parameter nodeName: 'type'.
	parameter attributeValue: '"integer"'.
	
	annotations := OrderedCollection new.
	
	annotationOne := PPPHPAnnotation new.
	annotationOne nodeName: (PPPHPNamespaceStack createFromCollection: {'ORM'. 'Assert'}).
	annotationOne parameters: {parameter}.
	
	annotations add: annotationOne.
	
	parameterTwo := PPPHPAttributeNode new.
	parameterTwo nodeName: 'class'.
	parameterTwo attributeValue: 'Some\Class'.
	
	parameterThree := PPPHPAttributeNode new.
	parameterThree nodeName: 2. "the index"
	parameterThree attributeValue: 'true'.
	
	annotationTwo := PPPHPAnnotation new.
	annotationTwo nodeName: (PPPHPNamespaceStack createFromCollection: {'Inject'}).
	annotationTwo parameters: { parameterTwo. parameterThree. }.
	
	annotations add: annotationTwo.
	
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAClass [
	| classnode inp |
	inp := MJPHPImporter new.
	classnode := PPPHPClassNode new.
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAField [
	| attribute inp |
	inp := MJPHPImporter new.
	attribute := inp ensureAField: fieldNode.
	
	self assert: (attribute isMemberOf: MJFAMIXPHPAttribute ).
	self assert: (attribute name = 'aField').
	self assert: (attribute isProtected).
	self assert: (attribute isPrivate not).
	self assert: (attribute defaultValue = 'array()').
	self assert: (attribute modifiers includes: #static).
	self assert: (attribute modifiers includes: #constant) not.
	
	
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureANamespace [
	| inp namespaceNode |
	inp := MJPHPImporter new.
	"\Vendor\Component\Class"
	namespaceNode := inp ensureANamespace: namespace.
	
	self assert: (namespaceNode isMemberOf: FAMIXNamespace).
	self assert: (namespaceNode name = 'Class').
	self assert: (namespaceNode parentScope notNil).
	self assert: (namespaceNode parentScope name = 'Component').
	self assert: (namespaceNode parentScope parentScope notNil).
	self assert: (namespaceNode parentScope parentScope name = 'Vendor').
	self assert: (namespaceNode parentScope parentScope parentScope notNil).
	self assert: (namespaceNode parentScope parentScope parentScope name = '\').
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAParameter [
	| param node inp |
	
	inp := MJPHPImporter new.

	node := PPPHPParameterNode new.
	node nodeName: 'parameter'.
	node typeHint: (PPPHPTypeNode createFromNamespaceStack: namespaceStack).
	node defaultValue: 'null'. ""
	
	param := inp ensureAParameter: node.
	
	self assert: (param isMemberOf: MJFAMIXPHPParameter).
	self assert: (param name = 'parameter').
	self assert: (param defaultValue = 'null').
	self assert: (param declaredType isMemberOf: FAMIXType).
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAnAnnotationMultipleInstances [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	annotation := inp ensureAnAnnotation: (annotations at: 2).
	annotation := inp ensureAnAnnotation: (annotations at: 2).
	
	self assert: (annotation annotationType isMemberOf: FAMIXAnnotationType).
	self assert: (annotation annotationType instances size = 2).
	
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAnAnnotationMultipleParameter [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	
	annotation := inp ensureAnAnnotation: (annotations at: 2).
	
	self assert: (annotation isMemberOf: FAMIXAnnotationInstance ).
	self assert: (annotation annotationType isMemberOf: FAMIXAnnotationType).
	self assert: (annotation name = 'Inject').
	self assert: (annotation attributes size = 2).
	
	attribute := annotation attributes at: 1.
	
	self assert: (attribute value = 'Some\Class').
	self assert: (attribute parentAnnotationInstance == annotation).
	self assert: (attribute annotationTypeAttribute isMemberOf: FAMIXAnnotationTypeAttribute ).
	self assert: (attribute annotationTypeAttribute annotationAttributeInstances size = 1).
	self assert: (attribute name = 'class' ).
	
	attribute := annotation attributes at: 2.
	
	self assert: (attribute value = 'true').
	self assert: (attribute parentAnnotationInstance == annotation).
	self assert: (attribute annotationTypeAttribute isMemberOf: FAMIXAnnotationTypeAttribute ).
	self assert: (attribute annotationTypeAttribute annotationAttributeInstances size = 1).
	self assert: (attribute name = 2 ). "just the index"
	
]

{ #category : #'as yet unclassified' }
MJPHPImporterTests >> testEnsureAnAnnotationSingleParameter [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	annotation := inp ensureAnAnnotation: (annotations at: 1).
	
	self assert: (annotation isMemberOf: FAMIXAnnotationInstance ).
	self assert: (annotation annotationType isMemberOf: FAMIXAnnotationType).
	self assert: (annotation name = 'ORM\Assert').
	self assert: (annotation attributes size = 1).
	
	attribute := annotation attributes at: 1.

	self assert: (attribute value = '"integer"').
	self assert: (attribute parentAnnotationInstance == annotation).
	self assert: (attribute annotationTypeAttribute isMemberOf: FAMIXAnnotationTypeAttribute ).
	self assert: (attribute annotationTypeAttribute annotationAttributeInstances size = 1).
	self assert: (attribute name = 'type' ).
]
