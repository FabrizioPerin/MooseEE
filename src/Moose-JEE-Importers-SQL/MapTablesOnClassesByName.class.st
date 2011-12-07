Class {
	#name : #MapTablesOnClassesByName,
	#superclass : #MJMappingStrategy,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnClassesByName >> buildMapsOn: aTargetModel [
	| classes tables counter |

	classes := (aTargetModel allClasses reject: #isStub) sorted: [:a :b | a name > b name].
	tables := aTargetModel allTables sorted: [:a :b | a name > b name].
	counter :=  1.

	UIManager default
	displayProgress: 'Building relations among DB and Classes'
		at: Sensor cursorPoint
		from: counter
		to: (classes size * tables size)
		during: [ :bar |
			counter := counter+1.
			bar value: counter.
			tables do: [:table | 
				classes do: [:class |
						(('.*',table name,'$') asRegexIgnoringCase matches: class name)
							ifTrue:[ |mapping|
									mapping := FAMIXMapping new mapTarget: table; mapSource: class.
									class addMaps: mapping.
									table addMappedBy: mapping.
									aTargetModel silentlyAdd: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]
