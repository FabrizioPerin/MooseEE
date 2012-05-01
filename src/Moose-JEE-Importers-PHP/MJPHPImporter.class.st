Class {
	#name : #MJPHPImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'phpParser',
		'phpVisitor'
	],
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImporter class >> on: aMooseModel [
	^self new targetModel: aMooseModel.
]

{ #category : #accessing }
MJPHPImporter >> ensureAClass: aPPPHPClassNode [
	| classNode inheritance |
	
	self flag: 'How to add an interface?'.
	classNode := MJFAMIXPHPClass new.
	classNode name: aPPPHPClassNode typeName.
	
	aPPPHPClassNode superTypes do: [ :superType |
			
			inheritance := FAMIXInheritance new.
			inheritance superclass: nil.
			inheritance subclass: classNode.
			
			classNode addSuperInheritance: nil.
		].
	
	classNode addSuperInheritance: inheritance.
	
	aPPPHPClassNode interfaces do: [ :interface |
			"The Class node has an is interface "
			classNode addInterface: nil.
		].
	
	aPPPHPClassNode behaviouralEntities do:[ :method |
			classNode addMethod: (self ensureAMethod: method).
		].
	^classNode.
]

{ #category : #accessing }
MJPHPImporter >> ensureAField: aPPPHPFieldNode [
	
	| fieldNode |
	fieldNode := self ensureAnAttribute: aPPPHPFieldNode.
]

{ #category : #accessing }
MJPHPImporter >> ensureAMethod: aPPPHPMethodNode [
	
	| methodNode |
	
	methodNode := MJFAMIXPHPMethod new.
	aPPPHPMethodNode parameters do: [
			methodNode addParameter: nil.
		].
	
]

{ #category : #accessing }
MJPHPImporter >> ensureANamespace: aPPPHPNamespaceStack [
	| spaceNode parentNode |
	
	parentNode := nil.
	aPPPHPNamespaceStack do: [ :item |
			spaceNode := MJFAMIXPHPNamespace new.
			spaceNode name: item namespaceName.
			spaceNode parentScope: parentNode.
			parentNode := spaceNode.
		].
	spaceNode
]

{ #category : #accessing }
MJPHPImporter >> ensureAParameter: aPPPHPParameterNode [
	
	| param |
	param := self ensureAnAttribute: aPPPHPParameterNode .
]

{ #category : #accessing }
MJPHPImporter >> ensureAnAttribute: aPPPHPAttributeNode [
	
	| attributeNode |
	attributeNode := MJFAMIXPHPAttribute new.
]

{ #category : #accessing }
MJPHPImporter >> import: aStream [
	self phpParser parse: aStream.
]

{ #category : #accessing }
MJPHPImporter >> initialize [

	phpVisitor := PPPHPConcreteVisitor new importer: self.
	phpParser := PPPHPCoreParser new.
]

{ #category : #accessing }
MJPHPImporter >> phpParser [
	^ phpParser
]

{ #category : #accessing }
MJPHPImporter >> phpVisitor [
	^ phpVisitor
]

{ #category : #accessing }
MJPHPImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJPHPImporter >> targetModel: anObject [
	targetModel := anObject
]
