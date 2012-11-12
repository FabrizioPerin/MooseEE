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
	| classNode |
	
	classNode := self ensureAType: 
					MJFAMIXPHPClass new 
					from: aPPPHPClassNode.
	
	aPPPHPClassNode interfaces do: [ :interface |
		"The Class node has an is interfac"
		classNode addInterface: (interface attach: self phpVisitor).
	].
	
	^ classNode.
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
				annotation := item attach: self phpVisitor.
				annotation annotatedEntity: methodNode.
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
	| file nodes |
	nodes 	:= self phpParser parse:  (aFile readStream contentsOfEntireFile).
	(nodes isMemberOf: PPFailure) ifFalse: [
		file	:= FAMIXFile new.
		file entities addAll: (nodes collect: [: node | (node isKindOf: PPPHPNode) ifTrue: [node accept: phpVisitor]]).
	] ifTrue: [
		DialogWindow new alert: 'Parsing of ',(aFile fullName),' failed with message',nodes message.
	].
	^self populateTargetModelFrom: file.
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
	"
	| dataBases counter aBlackBoard |
	
	dataBases := aCollectionOfEnsuredNodes select: [:aNode | aNode isMemberOf: FAMIXDataBase].
	alterTableStatements do: [:alterTable | self reifyAnAlterTableStatementFrom: alterTable.].  
	tables keysAndValuesDo: [:key :value | columns addAll: value columns].
	
	counter := 1.
	
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: (tables size + columns size)
		during: [ :bar | 
		
			counter := counter + 1.
			bar value: counter.
			bar value: 'Adding data base'.
			
			self targetModel addAll: dataBases.

			bar value: ('Adding ', tables size asString ,' tables').
			tables valuesDo: [:table | 
				self targetModel silentlyAdd: table.
				counter := counter + 1.
				bar value: counter].
			
			bar value: ('Adding' , columns size asString , 'attributes').	
			columns do: [:col |
				self targetModel silentlyAdd: col.
				counter := counter + 1.
				bar value: counter].	
				
			connect columns and tables
			self targetModel allTables do: [:table | table columns do: [:col | col ownerTable: table]].
			
			adding table's constraint to the model
			self targetModel allTables do: [:table | self targetModel silentlyAddAll: table constraints ].
			
			bar value: 'Computing primary keys constraints'.
			self computePrimaryKeys.
			
			bar value: 'Computing foreign keys constraints'.			
			self targetModel silentlyAddAll: self computeForeignKeys.].
	"
	^ self targetModel.
]

{ #category : #accessing }
MJPHPImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJPHPImporter >> targetModel: anObject [
	targetModel := anObject
]
