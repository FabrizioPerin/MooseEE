Class {
	#name : #MapTablesOnClassesUsingAnnotations,
	#superclass : #MJMappingStrategy,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnClassesUsingAnnotations >> buildMapsOn: aTargetModel [
	| tables tableEntities counter  ejbVer |

	aTargetModel ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					aTargetModel ejbVersion: ejbVer.].
	aTargetModel isEJB30 
	ifTrue:[	
		tableEntities := (aTargetModel allAnnotationTypes select: [:each | each name = 'Table']) flatCollect: [:each | each annotatedEntities ].

		tables := aTargetModel allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among Tables and Classes'
			from: counter
			to: (tableEntities size * tables size)
			during: [ :bar |
					counter := counter+1.
					bar value: counter.
				
					tables do: [:table | 
						tableEntities do: [:class |
							"(table nameWithAnnotationAsRegex matches: class sourceText)"
							((class sourceText findString: ('@Table(name = "',table name,'"') startingAt: 1 caseSensitive: false) > 0)
								ifTrue:[ |mapping|
									mapping := FAMIXMapping new mapTarget: table; mapSource: class.
									class addMaps: mapping.
									table addMappedBy: mapping.
									aTargetModel silentlyAdd: mapping.].
								counter := counter+1.
								bar value: counter]]]]
	ifFalse:[
		tableEntities := aTargetModel allClasses select: [:class | class methods anySatisfy: #doesExecuteAQuery].
		tables := aTargetModel allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among DB and Classes'
			from: counter
			to: (tableEntities size * tables size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.
			
				tables do: [:table | 
					tableEntities do: [:class |
						((class sourceText findString: table name) > 0)
								ifTrue:[ |mapping|
										mapping := FAMIXMapping new mapTarget: table; mapSource: class.
										class addMaps: mapping.
										table addMappedBy: mapping.
										aTargetModel silentlyAdd: mapping.].
								counter := counter+1.
								bar value: counter.
								]]]].
]
