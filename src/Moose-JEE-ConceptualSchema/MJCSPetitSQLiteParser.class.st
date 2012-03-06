Class {
	#name : #MJCSPetitSQLiteParser,
	#superclass : #PetitSQLiteASTNodesParser,
	#instVars : [
		'key',
		'tableConstraintPrimaryKeyOrIndexPartForMYSQL'
	],
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParser >> key [
	^'KEY' asParser caseInsensitive trim
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParser >> tableConstraint [
	"http://www.sqlite.org/syntaxdiagrams.html#table-constraint"

	^( ( constraint , identifier ) optional ,
	(tableConstraintPrimaryKeyPart /
	tableConstraintForeignKeyPart /
	tableConstraintPrimaryKeyOrIndexPartForMYSQL /
	tableConstraintCheckPart ) ) ==> [:token | 
		token first isNil ifFalse: [
			token second name: token first second ].
		token second].
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParser >> tableConstraintPrimaryKeyOrIndexPartForMYSQL [
	"http://www.sqlite.org/syntaxdiagrams.html#table-constraint"
	
	^(key , identifier optional ,  indexedColumnsInRoundParentheses , conflictClause) ==> [:token |
		| newConstr |

		newConstr := SQLTableConstraintNode new.


		newConstr isPKConstraint: true.
		newConstr isFKConstraint: false.
		newConstr isUnique: false.
				
		token third second do: [:el | el isArray 
				ifTrue: [el first isString ifTrue: [newConstr addPKColumnName: el first]]].

		newConstr]
]
