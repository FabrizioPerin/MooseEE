Class {
	#name : #MJPHPImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'phpParser',
		'phpVisitor',
		'annotationTypes',
		'sourceLanguage',
		'types',
		'defaultNamespace',
		'namespaces'
	],
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImporter class >> on: aMooseModel [
	^self new targetModel: aMooseModel.
]

{ #category : #accessing }
MJPHPImporter >> addAllAnnotations: anAnnotationTypeCollection [
	anAnnotationTypeCollection do: [ :annotation |
		self types at: annotation fullName ifAbsent:[
			self targetModel silentlyAdd: annotation.
		].
	].
]

{ #category : #accessing }
MJPHPImporter >> addAllNamespaces: aCollection [
	aCollection do: [ :space |
		self addNamespace: space
	].
]

{ #category : #accessing }
MJPHPImporter >> addNamespace: namespace [
	self targetModel silentlyAdd: namespace.
	self targetModel silentlyAddAll: namespace allChildScopes.
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
	nodeName := aPPPHPAnnotationNode fullyQualifiedTypeName.
	^ self annotationTypes
		at: nodeName
		ifAbsentPut: [ 
			type := MJFAMIXPHPAnnotation new.
			type name: nodeName asString.
			type
				isStub: true;
				yourself ]
]

{ #category : #accessing }
MJPHPImporter >> createAnnotationTypeAttributeFrom: aPPPHPAttributeNode on: aFAMIXAnnotationType [
	| attributes typeAttribute |
	attributes := aFAMIXAnnotationType attributes select: [ :item |
		item name = aPPPHPAttributeNode nodeName
	]. 
	attributes ifEmpty: [
		typeAttribute := FAMIXAnnotationTypeAttribute new.
		typeAttribute name: aPPPHPAttributeNode nodeName asString.
		typeAttribute parentAnnotationType: aFAMIXAnnotationType.
		^ typeAttribute.
	] ifNotEmpty:[
		^ attributes at: 1.
	].
	
]

{ #category : #accessing }
MJPHPImporter >> createComment: content [
	| comment |
	comment := FAMIXComment new.
	comment content: content.
	^ comment
]

{ #category : #accessing }
MJPHPImporter >> createNamespace: aPPPHPNamespaceNode [
	|collection|
	"remove classname"
	collection := aPPPHPNamespaceNode asSanitizedCollection.
	^ self createSubspaces: collection
]

{ #category : #accessing }
MJPHPImporter >> createSpaceFrom: aPPPHPNamespaceNode [
	^ MJFAMIXPHPNamespace new name: aPPPHPNamespaceNode namespaceName; yourself
]

{ #category : #accessing }
MJPHPImporter >> createSubspaces: aCollection [
	|node first |
	first := aCollection removeAtIndex: 1.
	node := self namespaces at: first namespaceName ifAbsentPut: [
		self createSpaceFrom: first
	].
	aCollection isEmpty ifFalse: [
		^ self createSubspaces: aCollection for: node
	].
	^ node
]

{ #category : #accessing }
MJPHPImporter >> createSubspaces: aCollection for: aNamespaceNode [
	| node space next |
	node := aCollection removeAtIndex: 1.
	space := nil.
	aNamespaceNode allChildScopesDo: [:child |
		child name = node namespaceName ifTrue: [
			space := child.
		].
	].
	space ifNil: [
		space := self createSpaceFrom: node.
	].
	space parentScope: aNamespaceNode.
	aCollection notEmpty ifTrue: [
		^ self createSubspaces: aCollection for: space
	].
	^ space
]

{ #category : #accessing }
MJPHPImporter >> createType: aPPPHPTypeNode [
	| nodeName |
	nodeName := aPPPHPTypeNode fullyQualifiedTypeName.
	^ self types
		at: nodeName
		ifAbsentPut: [ 
			| stubType parentNamespace |
			aPPPHPTypeNode isAnnotation
				ifTrue: [ stubType := self createAnnotationType: aPPPHPTypeNode ]
				ifFalse: [ stubType := MJFAMIXPHPClass new ].
			stubType name: aPPPHPTypeNode nodeName.
			stubType fullName: aPPPHPTypeNode fullyQualifiedTypeName.
			"transform the namespace"
			parentNamespace := aPPPHPTypeNode parentNamespace.
			(parentNamespace notNil and: [ parentNamespace isSeparator not ])
				ifTrue: [ (self createNamespace: parentNamespace) addType: stubType ].
			stubType
				stub: true;
				yourself ]
]

{ #category : #'as yet unclassified' }
MJPHPImporter >> defaultNamespace [
	^ defaultNamespace
]

{ #category : #accessing }
MJPHPImporter >> ensureAClass: aPPPHPClassNode [
	| classNode inheritance node |
	classNode := self createType: aPPPHPClassNode.
	self ensureAType: classNode from: aPPPHPClassNode.
	aPPPHPClassNode interfaces
		do: [ :interface | 
			inheritance := FAMIXInheritance new.
			inheritance superclass: (interface accept: self phpVisitor).
			inheritance subclass: classNode ].
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
	| function |
	function := FAMIXFunction new.
	function name: aPPPHPFunctionNode nodeName.
	aPPPHPFunctionNode parameters do: [ :param |
		function addParameter: ( param accept: self phpVisitor ).
	].
	^ function
]

{ #category : #accessing }
MJPHPImporter >> ensureAMethod: aPPPHPMethodNode [
	| methodNode annotation |
	methodNode := MJFAMIXPHPMethod new.
	methodNode name: aPPPHPMethodNode nodeName.
	methodNode isConstructor: methodNode name = '__construct'.
	methodNode isPublic: aPPPHPMethodNode scope isPublic.
	methodNode isProtected: aPPPHPMethodNode scope isProtected.
	methodNode isPrivate: aPPPHPMethodNode scope isPrivate.
	methodNode isAbstract: aPPPHPMethodNode isAbstract.
	methodNode isStatic: aPPPHPMethodNode isStatic.
	aPPPHPMethodNode hasDocBlock
		ifTrue: [ 
			methodNode addComment: (self createComment: aPPPHPMethodNode docBlock).
			aPPPHPMethodNode docBlockAnnotations
				ifNotNilDo: [ :item | 
					item
						do: [ :annot | 
							annotation := annot accept: self phpVisitor.
							annotation annotatedEntity: methodNode ] ] ].
	aPPPHPMethodNode parameters do: [ :param | methodNode addParameter: (param accept: self phpVisitor) ].
	aPPPHPMethodNode isAbstract
		ifFalse: [ self flag: 'TODO: add the body!' ].
	^ methodNode
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

	| inheritance annotation parentNamespace |
	(aPPPHPTypeNode isFragment and: [ aTypeNode isStub ]) "break"
		ifTrue: [ ^ aTypeNode ].
	aTypeNode isAbstract: aPPPHPTypeNode isAbstract.
	aPPPHPTypeNode superTypes
		do: [ :superType |
			"inheritances"
			inheritance := FAMIXInheritance new.
			inheritance superclass: (superType accept: self phpVisitor).
			inheritance subclass: aTypeNode ].	
	aPPPHPTypeNode attributes do: [ :attribute | aTypeNode addAttribute: (attribute accept: self phpVisitor) ].	"this is valid for all types"
	aPPPHPTypeNode behaviouralEntities do: [ :method | aTypeNode addMethod: (method accept: self phpVisitor) ].
	aPPPHPTypeNode hasDocBlock
		ifTrue: [ 
			aTypeNode addComment: (self createComment: aPPPHPTypeNode docBlock).
			aPPPHPTypeNode docBlockHasAnnotations
				ifTrue: [ 
					aPPPHPTypeNode docBlockAnnotations
						do: [ :item | 
							annotation := item accept: self phpVisitor.
							annotation annotatedEntity: aTypeNode ] ] ].
	aTypeNode isStub: false.
	types at: aTypeNode fullName put: aTypeNode.
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
	interfaceNode := self createType: aPPPHPInterfaceNode.
	interfaceNode isInterface: true.
	self ensureAType: interfaceNode from: aPPPHPInterfaceNode.
	interfaceNode allSuperclassesDo: [ :superType | superType isInterface: true ].
	^ interfaceNode
]

{ #category : #'as yet unclassified' }
MJPHPImporter >> importPHPFile: aFile [
	| file nodes entities folder contents |
	contents := [ (StandardFileStream readOnlyFileFullyNamed: aFile fullName) contentsOfEntireFile ]
		on: Error
		do: [ ^ PPFailure new initializeMessage: 'Unreadable File' at: 0 ].
	nodes := self phpParser parse: contents.
	nodes isPetitFailure
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
			^ file ].
	^ nodes
]

{ #category : #accessing }
MJPHPImporter >> initialize [

	phpVisitor 			:= PPPHPConcreteVisitor new importer: self.
	phpParser 			:= PPPHPCoreParser new.
	annotationTypes 	:= Dictionary new.
	types 				:= Dictionary new.
	namespaces 		:= Dictionary new.
	sourceLanguage 	:= FAMIXCustomSourceLanguage new name: 'PHP'.
	defaultNamespace 	:= FAMIXNamespace new.
]

{ #category : #accessing }
MJPHPImporter >> namespaces [
	^ namespaces
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
			(entity isKindOf: FAMIXFunction)
				ifTrue: [ 
					self targetModel silentlyAddAll: entity parameters.
					entity parameters
						do: [ :param | 
							param declaredType notNil
								ifTrue: [ self types at: param declaredType fullName ifAbsent: [ param declaredType isStub: true ] ] ] ].
			(entity isKindOf: FAMIXType)
				ifTrue: [ 
					self targetModel silentlyAddAll: entity superInheritances.
					self targetModel silentlyAddAll: entity subInheritances.
					self targetModel silentlyAddAll: entity comments.
					entity annotationInstances
						do: [ :annotation | 
							annotation annotationType isStub
								ifFalse: [ 
									self targetModel silentlyAdd: annotation.
									self targetModel silentlyAddAll: annotation attributes ] ].
					entity methods
						do: [ :method | 
							self targetModel silentlyAdd: method.
							self targetModel silentlyAddAll: method comments.
							method annotationInstances
								do: [ :annotation | 
									self targetModel silentlyAdd: annotation.
									self targetModel silentlyAddAll: annotation attributes ].
							self targetModel silentlyAddAll: method parameters.
							method parameters
								do: [ :param | 
									param declaredType notNil
										ifTrue: [ self types at: param declaredType fullName ifAbsent: [ param declaredType isStub: true ] ] ] ].
					entity attributes
						do: [ :attribute | 
							self targetModel add: attribute.
							self targetModel addAll: attribute comments.
							attribute annotationInstances
								do: [ :annotation | 
									self targetModel silentlyAdd: annotation.
									self targetModel silentlyAddAll: annotation attributes ] ] ] ].
	^ aFileNode
]

{ #category : #accessing }
MJPHPImporter >> populateTargetModelFromRootFolder: aFAMIXFolder [
	"add all the annotation types"
	self addAllAnnotations: annotationTypes.
	self addAllNamespaces: namespaces.
	"for each file track the content"
	aFAMIXFolder files do: [ :file | self populateTargetModelFrom: file ].
	"add remaining stubs"
	self targetModel silentlyAddAll: (self types select: [:type | type isStub ]).
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
	anObject sourceLanguage: self sourceLanguage.
	anObject add: self sourceLanguage.
	targetModel := anObject
]

{ #category : #accessing }
MJPHPImporter >> types [
	^ types
]
