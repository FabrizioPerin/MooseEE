Class {
	#name : #MapColumnsOnMethodsAndAttributes,
	#superclass : #MJMappingStrategy,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapColumnsOnMethodsAndAttributes >> buildMapsOn: aTargetModel [
	| attributesAndMethods classes counter allIndexes ejbVer|

	aTargetModel ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					aTargetModel ejbVersion: ejbVer.].
	aTargetModel isEJB30 
	ifTrue:[	
		attributesAndMethods := (aTargetModel allAnnotationTypes select: [:each | each name = #Column or: [each name = #GeneratedValue]]) flatCollect: [:each | each annotatedEntities ].
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
										mapping := FAMIXMapping new mapTarget: column; mapSource: method.
										method addMaps: mapping.
										column addMappedBy: mapping.
										aTargetModel silentlyAdd: mapping]]]].
				
					
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
										mapping := FAMIXMapping new mapTarget: currentCol; mapSource: currentAtt.
										currentAtt addMaps: mapping.
										currentCol addMappedBy: mapping.
										aTargetModel silentlyAdd: mapping.
										currentAtt := currentCol := nil.].
								
								internalCounter := internalCounter + 1.
								internalBar value: internalCounter. ]]].
				
					counter := counter+1.
					bar value: counter]].
]
