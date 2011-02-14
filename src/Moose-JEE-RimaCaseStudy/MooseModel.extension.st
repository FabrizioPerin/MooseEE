Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-RimaCaseStudy' }
MooseModel >> browseMappings [
	<menuItem: 'Rima Browser for mappings' category: 'JEAs Browsers'>
	MJRimaMappingBrowser new browser openOn: self	
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
MooseModel >> buildRelationsAmongTablesAndClassesByClassName [
	<menuItem: 'Build Relations Among Tables And Classes by class name' category: 'JEAs Importers'>

	| interfaces tables counter |
	interfaces := (self allClasses select: #isInterface)sorted: [:a :b | a name > b name].
	tables := self allTables sorted: [:a :b | a name > b name].
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
						(('.*',table name,'$') asRegex matches: interface name)
							ifTrue:[ |mapping|
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: interface.
									interface addMaps: mapping.
									table addMappedBy: mapping.
									self withoutAnnounceAdd: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]
