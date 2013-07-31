Class {
	#name : #MJPHPImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'namespace',
		'namespaceStack',
		'fieldNode',
		'annotations',
		'classNode',
		'parameters'
	],
	#category : #'Moose-JEE-Tests-Importers-PHP'
}

{ #category : #running }
MJPHPImporterTests >> setUp [
	| parameters |
	super setUp.
	
	namespaceStack 	:= PPPHPNamespaceStack createFromCollection: {'\'. 'Vendor'. 'Component'. 'Class'.}.
	namespace 		:= namespaceStack top.
	
]

{ #category : #running }
MJPHPImporterTests >> setUpAnnotations [
	"Returns an array of annotations"
	| a1 a2 a3 parameters |
	annotations ifNil: [
		parameters := self setUpParameters.
	
		a1 := PPPHPAnnotation new.
		a1 	nodeName: (PPPHPNamespaceStack createFromCollection: {'ORM'. 'Assert'});
			parameters: {parameters at: 4.}.
	
		a2 := PPPHPAnnotation new.
		a2 	nodeName: (PPPHPNamespaceStack createFromCollection: {'Inject'});
			parameters: {parameters at: 5. parameters at: 6. }.
		
		annotations := { a1. a2. }
	].
	^ annotations
]

{ #category : #running }
MJPHPImporterTests >> setUpFields [
	"Returns an array of fields"
	| f1 f2 |
	
	f1 := PPPHPFieldNode new.
	f1 nodeName: 'aField';
	scope: (PPPHPScopeNode new scope: 'protected');
	defaultValue: 'array()';
	isStatic: true.
	
	f2 := PPPHPFieldNode new.
	f2 nodeName: 'aConstant';
	scope: (PPPHPScopeNode new scope: 'public');
	defaultValue: '2';
	isConstant: true.
	
	^ {f1. f2.}
]

{ #category : #running }
MJPHPImporterTests >> setUpParameters [
	"Returns an array of parameters"

	parameters
		ifNil: [ 
			| p1 p2 p3 p4 p5 p6 p7 |
			p1 := PPPHPParameterNode new.
			p1
				nodeName: 'immediately';
				defaultValue: 'true'.
			p2 := PPPHPParameterNode new.
			p2
				nodeName: 'dialer';
				defaultValue: 'null';
				typeHint:
						(PPPHPNamespaceStack
								createFromCollection:
									{'\'.
									'Ambulance'.
									'Dialer'.
									'DialerInterface'}).
			p3 := PPPHPParameterNode new.
			p3 nodeName: 'useCache'.
			p4 := PPPHPAttributeNode new.
			p4
				nodeName: 'type';
				attributeValue: '"integer"'.
			p5 := PPPHPAttributeNode new.
			p5
				nodeName: 'class';
				attributeValue: 'Some\Class'.
			p6 := PPPHPAttributeNode new.
			p6
				nodeName: 2;
				attributeValue: 'true'.	"the index"
			p7 := PPPHPParameterNode new.
			p7
				nodeName: 'parameter';
				typeHint: (PPPHPTypeNode createFromNamespaceStack: namespaceStack);
				defaultValue: 'null'.	""
			parameters := {p1.
			p2.
			p3.
			p4.
			p5.
			p6.
			p7} ].
	^ parameters
]

{ #category : #tests }
MJPHPImporterTests >> testEnsureAClass [
	| classnode inp |
	inp := MJPHPImporter new.
	classnode := PPPHPClassNode new.
]

{ #category : #tests }
MJPHPImporterTests >> testEnsureAField [
	| attribute inp |
	inp := MJPHPImporter new.
	attribute := inp ensureAField: (self setUpFields at: 1).
	
	self assert: (attribute isMemberOf: MJFAMIXPHPAttribute ).
	self assert: (attribute name = 'aField').
	self assert: (attribute isProtected).
	self assert: (attribute isPrivate not).
	self assert: (attribute defaultValue = 'array()').
	self assert: (attribute modifiers includes: #static).
	self assert: (attribute modifiers includes: #constant) not.
	
	
]

{ #category : #tests }
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

{ #category : #tests }
MJPHPImporterTests >> testEnsureAParameter [
	| param node inp |
	
	inp := MJPHPImporter new.
	param := inp ensureAParameter: (self setUpParameters at: 7).
	
	self assert: (param isMemberOf: MJFAMIXPHPParameter).
	self assert: (param name = 'parameter').
	self assert: (param defaultValue = 'null').
	self assert: (param declaredType isKindOf: FAMIXType).
]

{ #category : #tests }
MJPHPImporterTests >> testEnsureAnAnnotationMultipleInstances [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	annotation := inp ensureAnAnnotation: (self setUpAnnotations at: 2).
	annotation := inp ensureAnAnnotation: (self setUpAnnotations at: 2).
	
	self assert: (annotation annotationType isMemberOf: FAMIXAnnotationType).
	self assert: (annotation annotationType instances size = 2).
	
]

{ #category : #tests }
MJPHPImporterTests >> testEnsureAnAnnotationMultipleParameter [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	
	annotation := inp ensureAnAnnotation: (self setUpAnnotations at: 2).
	
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
	self assert: (attribute name = 2 asString ). "just the index"
	
]

{ #category : #tests }
MJPHPImporterTests >> testEnsureAnAnnotationSingleParameter [
	| inp annotation attribute |
	inp := MJPHPImporter new.
	
	annotation := inp ensureAnAnnotation: (self setUpAnnotations at: 1).
	
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
