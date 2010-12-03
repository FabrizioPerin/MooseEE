Class {
	#name : #MJJSPImporter,
	#superclass : #Object,
	#category : #'Moose-JEE-Importers-JSP'
}

{ #category : #'as yet unclassified' }
MJJSPImporter >> populate: aMooseModel withJSPsFrom: aBlackBoard [

	| jsPage draftJSPage |
	
	
	draftJSPage := aBlackBoard jsPages last.
	
	jsPage := MJFAMIXJSPPage new.
	
	jsPage name: draftJSPage name.
	jsPage filedIn: draftJSPage filedIn.
	
	self halt.
	
	aMooseModel add: jsPage.
	"aMooseModel addAll: (dataBases flatCollect: [:each | each tables ]).
	aMooseModel addAll: (aMooseModel allTables flatCollect: [:table | table columns ])."
	
	^aMooseModel
]
