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
	classNode name: aPPPHPClassNode nodeName.
	
	aPPPHPClassNode superTypes do: [ :superType |
			
			inheritance := FAMIXInheritance new.
			inheritance superclass: nil.
			inheritance subclass: classNode.
			
			classNode addSuperInheritance: nil.
	].
	
	classNode addSuperInheritance: inheritance.
	
	aPPPHPClassNode interfaces do: [ :interface |
			"The Class node has an is interface "
			classNode addInterface: (MJFAMIXPHPClass new isInterface: true).
	].
	
	aPPPHPClassNode behaviouralEntities do:[ :method |
			classNode addMethod: (self ensureAMethod: method).
	].
	^classNode.
]

{ #category : #accessing }
MJPHPImporter >> ensureAField: aPPPHPFieldNode [
	| fieldNode |
	
	self flag: 'TODO: ensure annotations.'.
	
	fieldNode := MJFAMIXPHPAttribute new.
	fieldNode name: aPPPHPFieldNode nodeName.
	fieldNode isPrivate: aPPPHPFieldNode scope isPrivate.
	fieldNode isProtected: aPPPHPFieldNode scope isProtected.
	fieldNode isPublic: aPPPHPFieldNode scope isPublic.
	fieldNode modifierSet: aPPPHPFieldNode isStatic for: #static.
	fieldNode modifierSet: aPPPHPFieldNode isConstant for: #constant.
	fieldNode defaultValue: aPPPHPFieldNode defaultValue.
	
	^ fieldNode
]

{ #category : #accessing }
MJPHPImporter >> ensureAMethod: aPPPHPMethodNode [
	
	| methodNode |
	
	methodNode := MJFAMIXPHPMethod new.
	methodNode name: aPPPHPMethodNode nodeName.
	
	methodNode isPublic: aPPPHPMethodNode scope isPublic.
	methodNode isProtected: aPPPHPMethodNode scope isProtected.
	methodNode isPrivate: aPPPHPMethodNode scope isPrivate.
	methodNode isAbstract: aPPPHPMethodNode isAbstract.
	
	methodNode isStatic: aPPPHPMethodNode isStatic.
	
	aPPPHPMethodNode parameters do: [ :param |
		methodNode addParameter: (self ensureAParameter: param).
	].
	
]

{ #category : #accessing }
MJPHPImporter >> ensureANamespace: aPPPHPNamespaceNode [
	| scopeNode lastNode parentNode |
	scopeNode := FAMIXNamespace new.
	scopeNode name: aPPPHPNamespaceNode namespaceName.
	
	lastNode := aPPPHPNamespaceNode.
	(lastNode isRoot) ifFalse: [
		scopeNode parentScope: (self ensureANamespace: lastNode parentNamespace ).
	].
	^ scopeNode
]

{ #category : #accessing }
MJPHPImporter >> ensureAParameter: aPPPHPParameterNode [
	| param |
	param := MJFAMIXPHPParameter new.
	param name: aPPPHPParameterNode nodeName.
	aPPPHPParameterNode hasTypeHint ifTrue: [
		param declaredType: (self ensureAType: aPPPHPParameterNode typeHint).
	].
	aPPPHPParameterNode hasDefaultValue ifTrue: [
		param defaultValue: aPPPHPParameterNode defaultValue.
	].
	^ param.
]

{ #category : #accessing }
MJPHPImporter >> ensureAType: aPPPHPPNamespaceStack [
	| type |
	type := FAMIXType new.
	^type
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
