Class {
	#name : #MapColumnsOnMethodsAndAttributes,
	#superclass : #MJMappingStrategy,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapColumnsOnMethodsAndAttributes >> buildMapsOn: aTargetModel [
	| attributesAndMethods classes allIndexes ejbVer|

	aTargetModel ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					aTargetModel ejbVersion: ejbVer.].
	
	aTargetModel isEJB30 
	ifTrue:[	
		attributesAndMethods := (aTargetModel allAnnotationTypes select: [:each | each name = #Column or: [each name = #GeneratedValue]]) flatCollect: [:each | each annotatedEntities ].
		classes := (attributesAndMethods collect: [:each | each parentType ]) asSet.


		MooseCustomTask 	
			runWithProgress: [: bar | 
				bar increment.

				classes do: [:class |
					| source currentAtt currentCol dictionaryOfColumns dictionaryOfAttributes classAttributes tableColumns classMethods |
					source := class sourceText.
					dictionaryOfColumns := Dictionary new.
					dictionaryOfAttributes := Dictionary new.
					
					classAttributes := class attributes intersection: attributesAndMethods.
					classMethods := class methods intersection: attributesAndMethods.
					tableColumns := OrderedCollection new.
					class mappedRelationalEntities isEmpty ifFalse: [tableColumns := class mappedRelationalEntities first columns ].
					
					"try to match with methods"
					MooseCustomTask 	
						runWithProgress: [:internalBar | 
							"first try to match with methods"
							classMethods do: [:method |
								tableColumns do: [:column | 
									internalBar increment. 

									((method sourceText findString: ('@Column(name = "',column name,'"') startingAt: 1 caseSensitive: false) > 0) ifTrue: [
										| mapping |
										mapping := FAMIXMapping new mapTarget: column; mapSource: method.
										method addMaps: mapping.
										column addMappedBy: mapping.
										aTargetModel silentlyAdd: mapping]]]]
						description: 'Trying to match with methods'
		 				length: (classMethods size * tableColumns size). 
						
						
				
					
					"now try to match the rest"
					bar increment.
					
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
					
					MooseCustomTask 	
						runWithProgress: [:internalBar | 
							allIndexes do: [:ind |
								| mapping |
							
								"(class name = 'CustomerClass') ifTrue:[self halt]. "
							
								dictionaryOfColumns at: ind ifPresent: [:col | 
									currentCol := col].
						
								dictionaryOfAttributes at: ind ifPresent: [:att |
									currentAtt := att].
							
								(currentCol isNil not and: [currentAtt isNil not]) 
									ifTrue: [
										mapping := FAMIXMapping new mapTarget: currentCol; mapSource: currentAtt.
										currentAtt addMaps: mapping.
										currentCol addMappedBy: mapping.
										aTargetModel silentlyAdd: mapping.
										currentAtt := currentCol := nil.].
								
								internalBar increment ]]
						description: 'Trying to match with attributes'
		 				length: allIndexes size.
				
					bar increment ] ]
			description: 'Building relations between columns and methods and attributes'
		 	length: classes size + 1]
]
