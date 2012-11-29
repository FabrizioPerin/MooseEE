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
	| classNode inheritance |
	classNode := self ensureAType: MJFAMIXPHPClass new from: aPPPHPClassNode.
	aPPPHPClassNode interfaces
		do: [ :interface | 
			inheritance := FAMIXInheritance new.
			inheritance isInterface: true.
			inheritance superclass: (interface attach: self phpVisitor).
			inheritance subclass: interface.
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
					annotation := annot attach: self phpVisitor.
					annotation annotatedEntity: methodNode.
				].
			]. 
	].
	aPPPHPMethodNode parameters do: [ :param |
		methodNode addParameter: ( param attach: self phpVisitor ).
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
	(lastNode isRoot) ifFalse: [
		scopeNode parentScope: (lastNode parentNamespace attach: self phpVisitor ).
	].
	^ scopeNode
]

{ #category : #accessing }
MJPHPImporter >> ensureAParameter: aPPPHPParameterNode [
	| param |
	param := MJFAMIXPHPParameter new.
	param name: aPPPHPParameterNode nodeName.
	aPPPHPParameterNode hasTypeHint ifTrue: [
		param declaredType: (aPPPHPParameterNode typeHint attach: self phpVisitor).
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
		inheritance superclass: (superType attach: self phpVisitor).
		inheritance subclass: aTypeNode.
			
		aTypeNode addSuperInheritance: inheritance.
	].
	"This is valid for all types"
	aPPPHPTypeNode attributes do: [:attribute | 
		aTypeNode addAttribute: (attribute attach: self phpVisitor).
	].
	"this is valid for all types"
	aPPPHPTypeNode behaviouralEntities do:[ :method |
			aTypeNode addMethod: (method attach: self phpVisitor).
	].
	"this is valid for all types"
	aPPPHPTypeNode docBlockHasAnnotations ifTrue: [
		aPPPHPTypeNode docBlockAnnotations do: [ :item | 
			annotation := (item attach: self phpVisitor).
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
	
	interfaceNode superTypes do: [ :superType | superType isInterface: true. ].
	
	^ interfaceNode.
]

{ #category : #'as yet unclassified' }
MJPHPImporter >> importPHPFile: aFile [
	| file nodes entities folder lang |
	lang := FAMIXCustomSourceLanguage new.
	lang name: 'PHP'.
	
	nodes := self phpParser parse: aFile readStream contentsOfEntireFile.
	(nodes isMemberOf: PPFailure)
		ifFalse: [
			file := FAMIXFile named: aFile fullName filedIn: folder.
			entities := nodes
				collect: [ :node | 
					(node isKindOf: PPPHPNode)
						ifTrue: [ node accept: self phpVisitor ] ]
				thenSelect: [ :item | item notNil ].
			entities do: [:item | 
				item declaredSourceLanguage: lang.
				file entities add: item.
				].
			^ self populateTargetModelFrom: file ]
		ifTrue: [ ^ nodes ]
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
MJPHPImporter >> populateTargetModelFrom: aFileNode [
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
MJPHPImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJPHPImporter >> targetModel: anObject [
	targetModel := anObject
]
