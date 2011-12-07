Class {
	#name : #MapTablesOnInterfacesByName,
	#superclass : #MJMappingStrategy,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnInterfacesByName >> buildMapsOn: aTargetModel [
	| interfaces tables counter | 
	
	interfaces := ((aTargetModel allClasses select: #isInterface) reject: #isStub) sorted: [:a :b | a name > b name].
	tables := aTargetModel allTables sorted: [:a :b | a name > b name].
	counter :=  1.

	UIManager default
	displayProgress: 'Building relations among DB and Classes'
		at: Sensor cursorPoint
		from: counter
		to: (interfaces size * tables size)
		during: [ :bar |
			counter := counter+1.
			bar value: counter.
			tables do: [:table | 
				interfaces do: [:interface |
						(('.*',table name,'$') asRegexIgnoringCase matches: interface name)
							ifTrue:[ |mapping|
									mapping := FAMIXMapping new mapTarget: table; mapSource: interface.
									interface addMaps: mapping.
									table addMappedBy: mapping.
									aTargetModel silentlyAdd: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]
