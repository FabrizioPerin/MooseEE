Class {
	#name : #MJMappingStrategy,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJMappingStrategy class >> on: aMooseModel [
	
	^self new initialize: aMooseModel.
]

{ #category : #'as yet unclassified' }
MJMappingStrategy >> buildRelationsAmongDBTablesAndClasses [
	"<menuItem: 'Build Relations Among Tables And Classes' category: 'JEAs Importers'>"

	| tables tableEntities counter annotationTypeTable ejbVer |

	targetModel ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					targetModel ejbVersion: ejbVer.].
	targetModel isEJB30 
	ifTrue:[	
		tableEntities := (targetModel allAnnotationTypes select: [:each | each name = 'Table']) flatCollect: [:each | each annotatedEntities ].

		tables := targetModel allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among Tables and Classes'
			at: Sensor cursorPoint
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
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
									class addMaps: mapping.
									table addMappedBy: mapping.
									targetModel withoutAnnounceAdd: mapping.].
								counter := counter+1.
								bar value: counter]]]]
	ifFalse:[
		tableEntities := targetModel allClasses select: [:class | class methods anySatisfy: #doesExecuteAQuery].
		tables := targetModel allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among DB and Classes'
			at: Sensor cursorPoint
			from: counter
			to: (tableEntities size * tables size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.
			
				tables do: [:table | 
					tableEntities do: [:class |
						((class sourceText findString: table name) > 0)
								ifTrue:[ |mapping|
										mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
										class addMaps: mapping.
										table addMappedBy: mapping.
										targetModel withoutAnnounceAdd: mapping.].
								counter := counter+1.
								bar value: counter.
								]]]].
]

{ #category : #'as yet unclassified' }
MJMappingStrategy >> buildRelationsAmongTableColumnsAndMethodsAndAttributes [
	"<menuItem: 'Build Relations Among Columns And Methods' category: 'JEAs Importers'>"

	| attributesAndMethods classes counter allIndexes ejbVer|

	targetModel ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					targetModel ejbVersion: ejbVer.].
	targetModel isEJB30 
	ifTrue:[	
		attributesAndMethods := (targetModel allAnnotationTypes select: [:each | each name = #Column or: [each name = #GeneratedValue]]) flatCollect: [:each | each annotatedEntities ].
		classes := (attributesAndMethods collect: [:each | each parentType ]) asSet.

		counter :=  1.
		
		UIManager default
			displayProgress: 'Building relations among Columns and Attributes'
			at: Sensor cursorPoint
			from: counter
			to: classes size
			during: [ :bar |
				counter := counter+1.
				bar value: counter.

				classes do: [:class |
					| source currentAtt currentCol dictionaryOfColumns dictionaryOfAttributes classAttributes tableColumns internalCounter classMethods |
					source := class sourceText.
					dictionaryOfColumns := Dictionary new.
					dictionaryOfAttributes := Dictionary new.
					
					classAttributes := class attributes intersection: attributesAndMethods.
					classMethods := class methods intersection: attributesAndMethods.
					tableColumns := OrderedCollection new.
					class mappedRelationalEntities isEmpty ifFalse: [tableColumns := class mappedRelationalEntities first columns ].
					
					"try to match with methods"
					internalCounter := 1.
					UIManager default
						displayProgress: 'Trying to match with methods'
						at: Sensor cursorPoint
						from: 1
						to: (classMethods size * tableColumns size)
						during: [ :internalBar |
														
							"first try to match with methods"
							classMethods do: [:method |
								tableColumns do: [:column | 
									
									internalCounter := internalCounter + 1.
									internalBar value: internalCounter. 

									((method sourceText findString: ('@Column(name = "',column name,'"') startingAt: 1 caseSensitive: false) > 0) ifTrue: [
										| mapping |
										mapping := MJFAMIXMapping new mapTarget: column; mapSource: method.
										method addMaps: mapping.
										column addMappedBy: mapping.
										targetModel withoutAnnounceAdd: mapping]]]].
				
					
					"now try to match the rest"
					counter := counter+1.
					bar value: counter.
					
					tableColumns do: [:column | 
						| ind |
						"(class name = 'CustomerClass' and: [column name = 'CM_CLASS_ID']) ifTrue: [self halt.]."
						ind := (source findString: ('@Column(name = "',column name,'"') startingAt: 1 caseSensitive: false).
						(ind = 0) ifFalse: [dictionaryOfColumns at: ind put: column]].
				
					classAttributes do: [:attr |
						| ind |
						ind := (source findString: (attr declaredType name,' ',attr name)).
						"ind := (('.* ',attr name,'.*') asRegex matches: source)."
						(ind = 0) ifFalse: [dictionaryOfAttributes at: ind put: attr]].
					
					allIndexes := OrderedCollection withAll: (dictionaryOfColumns keys).
					allIndexes addAll: dictionaryOfAttributes keys.
					allIndexes := allIndexes sorted.
					
					currentAtt := currentCol := nil.
					
					internalCounter := 1.
					UIManager default
						displayProgress: 'Trying to match with attributes'
						at: Sensor cursorPoint
						from: 1
						to: allIndexes size
						during: [ :internalBar |
							allIndexes do: [:ind |
								| mapping |
							
								"(class name = 'CustomerClass') ifTrue:[self halt]. "
							
								dictionaryOfColumns at: ind ifPresent: [:col | 
									currentCol := col].
						
								dictionaryOfAttributes at: ind ifPresent: [:att |
									currentAtt := att].
							
								(currentCol isNil not and: [currentAtt isNil not]) 
									ifTrue: [
										mapping := MJFAMIXMapping new mapTarget: currentCol; mapSource: currentAtt.
										currentAtt addMaps: mapping.
										currentCol addMappedBy: mapping.
										targetModel withoutAnnounceAdd: mapping.
										currentAtt := currentCol := nil.].
								
								internalCounter := internalCounter + 1.
								internalBar value: internalCounter. ]]].
				
					counter := counter+1.
					bar value: counter]].
]

{ #category : #'as yet unclassified' }
MJMappingStrategy >> buildRelationsAmongTablesAndAllClassesByName [
	"<menuItem: 'Build Relations Among Tables And All Classes by name' category: 'JEAs Importers'>"

	| classes tables counter |
	classes := (targetModel allClasses reject: #isStub) sorted: [:a :b | a name > b name].
	tables := targetModel allTables sorted: [:a :b | a name > b name].
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
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
									class addMaps: mapping.
									table addMappedBy: mapping.
									targetModel withoutAnnounceAdd: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]

{ #category : #'as yet unclassified' }
MJMappingStrategy >> buildRelationsAmongTablesAndInterfacesByName [
	"<menuItem: 'Build Relations Among Tables And Interfaces by name' category: 'JEAs Importers'>"

	| interfaces tables counter |
	interfaces := ((targetModel allClasses select: #isInterface) reject: #isStub) sorted: [:a :b | a name > b name].
	tables := targetModel allTables sorted: [:a :b | a name > b name].
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
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: interface.
									interface addMaps: mapping.
									table addMappedBy: mapping.
									targetModel withoutAnnounceAdd: mapping.].
							counter := counter+1.
							bar value: counter.
							]]].
]

{ #category : #initialization }
MJMappingStrategy >> initialize: aMooseModel [

	targetModel := aMooseModel.
	
	^self
]
