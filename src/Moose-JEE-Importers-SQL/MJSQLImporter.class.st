Class {
	#name : #MJSQLImporter,
	#superclass : #Object,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateAColumnFrom: aDraftObject [
	
	
	| att |
	
	att := MJFAMIXColumn new.
	att name: aDraftObject name.

	^att
	
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateADataBaseFrom: aDraftObject [
		
	| dB |
	
	dB := MJFAMIXDataBase new.
	dB name: aDraftObject name.
	dB tables: (aDraftObject tables collect: [:aTableRepresentation | self instanciateADataBaseTableFrom: aTableRepresentation ]).
		
	^dB
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateADataBaseTableFrom: aDraftObject [
	
	| tab |
	
	tab := MJFAMIXTable new.
	tab name: aDraftObject name.
	tab columns: (aDraftObject attributes collect: [:aColumnRepresentation | self instanciateAColumnFrom: aColumnRepresentation ]).   
	
	^tab
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> populate: aMooseModel withRelationalElementsFrom: aBlackBoard [

	| dataBases |

	dataBases := aBlackBoard databases collect: [:aDBRepresentation | self instanciateADataBaseFrom: aDBRepresentation ].

	aMooseModel addAll: dataBases.
	aMooseModel addAll: (dataBases flatCollect: [:each | each tables ]).
	aMooseModel addAll: (aMooseModel allTables flatCollect: [:table | table columns ]).
	
	^aMooseModel
]
