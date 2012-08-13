Class {
	#name : #MJPHPImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'phpParser',
		'phpVisitor',
		'annotationTypes'
	],
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImporter class >> on: aMooseModel [
	^self new targetModel: aMooseModel.
]

{ #category : #accessing }
MJPHPImporter >> annotationTypes [
	^ annotationTypes
]

{ #category : #accessing }
MJPHPImporter >> annotationTypes: anObject [
	annotationTypes := anObject
]

{ #category : #accessing }
MJPHPImporter >> createAnnotationType: aPPPHPAnnotationNode [
	| type |
	annotationTypes at: aPPPHPAnnotationNode nodeName fullyQualifiedNamespaceName
	ifAbsentPut: [
		type := FAMIXAnnotationType new.
		type name: aPPPHPAnnotationNode nodeName fullyQualifiedNamespaceName.
		type.
	].
	self flag: 'recheck the attributes'.
	^ annotationTypes at: aPPPHPAnnotationNode nodeName fullyQualifiedNamespaceName.
	
]

{ #category : #accessing }
MJPHPImporter >> createAnnotationTypeAttributeFrom: aPPPHPAttributeNode on: aFAMIXAnnotationType [
	| attributes typeAttribute |
	attributes := aFAMIXAnnotationType attributes select: [ :item |
		item name = aPPPHPAttributeNode nodeName
	]. 
	attributes ifEmpty: [
		typeAttribute := FAMIXAnnotationTypeAttribute new.
		typeAttribute name: aPPPHPAttributeNode nodeName.
		typeAttribute parentAnnotationType: aFAMIXAnnotationType.
		^ typeAttribute.
	] ifNotEmpty:[
		^ attributes at: 1.
	].
	
]

{ #category : #accessing }
MJPHPImporter >> ensureAClass: aPPPHPClassNode [
	| classNode inheritance annotation |
	
	self flag: 'How to add an interface?'.
	classNode := MJFAMIXPHPClass new.
	classNode name: aPPPHPClassNode nodeName.
	
	aPPPHPClassNode superTypes do: [ :superType |
			
			inheritance := FAMIXInheritance new.
			inheritance superclass: (self ensureAClass: superType).
			inheritance subclass: classNode.
			
			classNode addSuperInheritance: inheritance.
	].
	
	aPPPHPClassNode interfaces do: [ :interface |
			"The Class node has an is interface "
			classNode addInterface: (MJFAMIXPHPClass new isInterface: true).
	].
	
	aPPPHPClassNode behaviouralEntities do:[ :method |
			classNode addMethod: (self ensureAMethod: method).
	].
	aPPPHPClassNode docBlockHasAnnotations ifTrue: [
		aPPPHPClassNode docBlockAnnotations do: [ :item | 
			annotation := (self ensureAnAnnotation: item).
			annotation annotatedEntity: classNode.
		].
	].
	^classNode.
]

{ #category : #accessing }
MJPHPImporter >> ensureAField: aPPPHPFieldNode [
	| fieldNode |
	
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
	
	| methodNode annotation|
	
	methodNode := MJFAMIXPHPMethod new.
	methodNode name: aPPPHPMethodNode nodeName.
	methodNode isConstructor: methodNode name = '__construct'.
	
	methodNode isPublic: aPPPHPMethodNode scope isPublic.
	methodNode isProtected: aPPPHPMethodNode scope isProtected.
	methodNode isPrivate: aPPPHPMethodNode scope isPrivate.
	methodNode isAbstract: aPPPHPMethodNode isAbstract.
	methodNode isStatic: aPPPHPMethodNode isStatic.
	
	aPPPHPMethodNode hasDocBlock ifTrue: [
		methodNode addComment: aPPPHPMethodNode docBlock.
			aPPPHPMethodNode docBlockAnnotations ifNotNilDo: [ :item |
				annotation := self ensureAnAnnotation: item.
				annotation annotatedEntity: methodNode.
			]. 
	].
	aPPPHPMethodNode parameters do: [ :param |
		methodNode addParameter: (self ensureAParameter: param).
	].
	aPPPHPMethodNode isAbstract ifFalse: [
		self flag: 'TODO: add the body!'.
	].
]

{ #category : #accessing }
MJPHPImporter >> ensureANamespace: aPPPHPNamespaceNode [
	"Recursively bubbles up the passed namespace and returns the representation of the passed node (linked to its parents)"
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
MJPHPImporter >> ensureAType: aNode [
	^ FAMIXType new.
]

{ #category : #accessing }
MJPHPImporter >> ensureAnAnnotation: aPPPHPAnnotationNode [
	| annotation annotationType annotationParameters annotationParameter |
	
	annotation := FAMIXAnnotationInstance new.
	annotation annotationType: (self createAnnotationType: aPPPHPAnnotationNode).
	
	aPPPHPAnnotationNode hasParameters ifTrue: [
		aPPPHPAnnotationNode parameters do: [ :aPPPHPAttributeNode |
			annotationParameter := FAMIXAnnotationInstanceAttribute new.
			annotationParameter value: aPPPHPAttributeNode attributeValue.
			annotationParameter parentAnnotationInstance: annotation.
			annotationParameter annotationTypeAttribute: (self createAnnotationTypeAttributeFrom: aPPPHPAttributeNode on: annotation annotationType).
		].
	].

	^ annotation.
]

{ #category : #accessing }
MJPHPImporter >> import: aStream [
	self phpParser parse: aStream.
]

{ #category : #accessing }
MJPHPImporter >> initialize [

	phpVisitor 			:= PPPHPConcreteVisitor new importer: self.
	phpParser 			:= PPPHPCoreParser new.
	annotationTypes 	:= Dictionary new. 
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
