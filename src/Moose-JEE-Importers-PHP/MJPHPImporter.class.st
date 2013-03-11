Class {
	#name : #MJPHPImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'phpParser',
		'phpVisitor',
		'annotationTypes',
		'sourceLanguage',
		'types'
	],
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImporter class >> on: aMooseModel [
	^self new targetModel: aMooseModel.
]

{ #category : #accessing }
MJPHPImporter >> addAllAnnotations: anAnnotationTypeCollection [
	self flag: 'resolve aliases and link it up to defined classes'.
	self targetModel silentlyAddAll: anAnnotationTypeCollection.
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
	| type nodeName |
	
	nodeName := aPPPHPAnnotationNode nodeName.
	(nodeName isKindOf: PPPHPNamespaceStack )
		ifTrue: [ 
			nodeName := nodeName fullyQualifiedNamespaceName. ].
		
	annotationTypes
		at: nodeName
		ifAbsentPut: [ 
			type := FAMIXAnnotationType new.
			type name: nodeName.
			type isStub: true.
			type ].
		
	^ annotationTypes at: nodeName
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
	| classNode inheritance |
	classNode := self ensureAType: MJFAMIXPHPClass new from: aPPPHPClassNode.
	aPPPHPClassNode interfaces
		do: [ :interface | 
			inheritance := FAMIXInheritance new.
			inheritance superclass: (interface accept: self phpVisitor).
			inheritance subclass: classNode.
			classNode addSuperInheritance: inheritance ].
	^ classNode
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
MJPHPImporter >> ensureAFile: aFile [
	| famFile |
	^ FAMIXFile named: aFile fullName filedIn: aFile directory.
]

{ #category : #accessing }
MJPHPImporter >> ensureAFunction: aPPPHPFunctionNode [
	^ aPPPHPFunctionNode
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
				item do: [ :annot |
					annotation := annot accept: self phpVisitor.
					annotation annotatedEntity: methodNode.
				].
			]. 
	].
	aPPPHPMethodNode parameters do: [ :param |
		methodNode addParameter: ( param accept: self phpVisitor ).
	].
	aPPPHPMethodNode isAbstract ifFalse: [
		self flag: 'TODO: add the body!'.
	].
	
	^ methodNode.
]

{ #category : #accessing }
MJPHPImporter >> ensureANamespace: aPPPHPNamespaceNode [
	"Recursively bubbles up the passed namespace and returns the representation of the passed node (linked to its parents)"

	| scopeNode lastNode parentNode |
	scopeNode := FAMIXNamespace new.
	scopeNode name: aPPPHPNamespaceNode namespaceName.
	lastNode := aPPPHPNamespaceNode.
	lastNode isRoot
		ifFalse: [ scopeNode parentScope: (lastNode parentNamespace accept: self phpVisitor) ].
	^ scopeNode
]

{ #category : #accessing }
MJPHPImporter >> ensureAParameter: aPPPHPParameterNode [
	| param |
	param := MJFAMIXPHPParameter new.
	param name: aPPPHPParameterNode nodeName.
	aPPPHPParameterNode hasTypeHint ifTrue: [
		param declaredType: (aPPPHPParameterNode typeHint accept: self phpVisitor).
	].
	aPPPHPParameterNode hasDefaultValue ifTrue: [
		param defaultValue: aPPPHPParameterNode defaultValue.
	].
	^ param.
]

{ #category : #accessing }
MJPHPImporter >> ensureAType: aTypeNode from: aPPPHPTypeNode [
	"this one expects the original node and the correct famix node"
	| inheritance annotation |
	aTypeNode name: aPPPHPTypeNode nodeName.
	
	"this is valid for all types, but supertypes have to be set to isInterface on interfaces"
	aPPPHPTypeNode superTypes do: [ :superType |
		
		inheritance := FAMIXInheritance new.
		inheritance superclass: (superType accept: self phpVisitor).
		inheritance subclass: aTypeNode.
			
		aTypeNode addSuperInheritance: inheritance.
	].
	"This is valid for all types"
	aPPPHPTypeNode attributes do: [:attribute | 
		aTypeNode addAttribute: (attribute accept: self phpVisitor).
	].
	"this is valid for all types"
	aPPPHPTypeNode behaviouralEntities do:[ :method |
			aTypeNode addMethod: (method accept: self phpVisitor).
	].
	"this is valid for all types"
	aPPPHPTypeNode docBlockHasAnnotations ifTrue: [
		aPPPHPTypeNode docBlockAnnotations do: [ :item | 
			annotation := (item accept: self phpVisitor).
			annotation annotatedEntity: aTypeNode.
		].
	].
	^ aTypeNode
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
MJPHPImporter >> ensureAnInterface: aPPPHPInterfaceNode [
	| interfaceNode |
	interfaceNode := self ensureAType: 
					(MJFAMIXPHPClass new isInterface: true) 
					from: aPPPHPInterfaceNode.
	
	interfaceNode allSuperclassesDo: [ :superType | superType isInterface: true. ].
	^ interfaceNode.
]

{ #category : #'as yet unclassified' }
MJPHPImporter >> importPHPFile: aFile [
	| file nodes entities folder |
	nodes := self phpParser parse: aFile readStream contentsOfEntireFile.
	(nodes isMemberOf: PPFailure)
		ifFalse: [ 
			file := FAMIXFile named: aFile fullName filedIn: folder.
			entities := nodes
				collect: [ :node | 
					(node isKindOf: PPPHPNode)
						ifTrue: [ node accept: self phpVisitor ] ]
				thenSelect: [ :item | item notNil ].
			entities
				do: [ :item | 
					item declaredSourceLanguage: sourceLanguage.
					file entities add: item ].
			^ file ]
		ifTrue: [ ^ nodes ]
]

{ #category : #accessing }
MJPHPImporter >> initialize [

	phpVisitor 			:= PPPHPConcreteVisitor new importer: self.
	phpParser 			:= PPPHPCoreParser new.
	annotationTypes 	:= Dictionary new.
	types 				:= Dictionary new.
	sourceLanguage 	:= FAMIXCustomSourceLanguage new name: 'PHP'.
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
MJPHPImporter >> populateTargetModelFrom: aFileNode [
	"we need to check if the given annotation type or class exists otherwise we need to mark it as a stub!"
	self targetModel silentlyAdd: aFileNode.
	aFileNode entities
		do: [ :entity | 
			self targetModel silentlyAdd: entity.
			(entity isMemberOf: MJFAMIXPHPClass)
				ifTrue: [
					self targetModel silentlyAddAll: entity superInheritances.
					entity methods
						do: [ :method |
							 
							self targetModel silentlyAdd: method.
							self targetModel silentlyAddAll: method annotationInstances.
							self targetModel silentlyAddAll: method parameters.
							
							method parameters do: [:param | 
									param declaredType notNil ifTrue: [
											"self targetModel silentlyAdd: param declaredType."
										].
								].
							].
					entity attributes do: [ :attribute | self targetModel silentlyAdd: attribute ] ] ].
	^ aFileNode
]

{ #category : #accessing }
MJPHPImporter >> populateTargetModelFromRootFolder: aFAMIXFolder [
	"This method was added to make it possible to track all types first.
		1. iterate over files -
		2. get the entities, filter types and add them to the model -
		3. reiterate the entities and add:
			3.1. type annotations
			3.2. properties
				3.2.1. annotations
			3.3. methods
				3.3.1. parameters
				3.3.2. annotations"
	"remove duplicates"
	"add all types, otherwise moose is failing"
	aFAMIXFolder files do: [ :file | self targetModel silentlyAddAll: (file entities select: [ :node |  node isKindOf: FAMIXType ]) ].
	"add all the annotation types"
	self addAllAnnotations: annotationTypes.
	"for each file track the content"
	aFAMIXFolder files do: [ :file | self populateTargetModelFrom: file ].
	self targetModel silentlyAdd: aFAMIXFolder.
]

{ #category : #accessing }
MJPHPImporter >> sourceLanguage [
	^ sourceLanguage
]

{ #category : #accessing }
MJPHPImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJPHPImporter >> targetModel: anObject [
	targetModel := anObject
]
