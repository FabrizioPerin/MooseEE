Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-RimaCaseStudy' }
MooseModel >> buildRelationsAmongTablesAndClassesByClassName [
	<menuItem: 'Build Relations Among Tables And Classes by class name' category: 'JEAs Menu'>

	| interfaces tables counter |
	interfaces := self allInterfaces.
	tables := self allTables.
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
						((interface name findString: table name) > 0)
							ifTrue:[ |mapping|
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: interface.
									interface addMaps: mapping.
									table addMappedBy: mapping.
									self add: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]
