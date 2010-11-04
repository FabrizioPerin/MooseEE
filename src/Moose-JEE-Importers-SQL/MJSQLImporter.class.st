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
MJSQLImporter >> instanciateADataBaseTableFrom: aDraftObjectTable [
	
	| tab |
	
	tab := MJFAMIXTable new.
	tab name: aDraftObjectTable name.
	tab columns: (aDraftObjectTable attributes collect: [:aColumnRepresentation | self instanciateAColumnFrom: aColumnRepresentation ]).   
	aDraftObjectTable constraints isEmpty
		ifFalse: [
			aDraftObjectTable constraints do: [:constraint | 
				constraint isPKConstraint ifTrue: [constraint pkAttributeNames do: [:attNames |
						(tab columns select: [:col | col name = attNames]) first isPK: true]
				].
			].
		].
	
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
