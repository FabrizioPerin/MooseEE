Class {
	#name : #MJCCLCSExperimentsOnAdempiere,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'threshold'
	],
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere class >> on: aTargetModel [
	^ self new targetModel: aTargetModel ; threshold: 3.
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> LCSSOn: aCollectionOfNames [

	| result aStream lcssAlgo |
	
	aStream := MultiByteFileStream forceNewFileNamed:  'output.csv'.
	MJLongestCommonSubString writeCVSEntryHeaderOn: aStream.

	MooseCustomTask 
		runWithProgress:  [ :bar | 
			(1 to: aCollectionOfNames size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: aCollectionOfNames size)
						do: [ :secondIndex |
							self computeLCSSOf: (aCollectionOfNames at: firstIndex) name and: (aCollectionOfNames at: secondIndex) name andPrintFilteredResultsOn: aStream.
							bar increment ] ] ]
		description:  'Computing LCSS among all the elements in the collection' 
		length: ((aCollectionOfNames size * aCollectionOfNames size) / 2) asInteger.
	
	aStream close 
]

{ #category : #experiments }
MJCCLCSExperimentsOnAdempiere >> activeRecordExp1 [
	self threshold: 5.
	self LCSSOn: self importActiveRecordClassListFromactiveRecordsTxt 
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> computeLCSSOf: aString and: anotherString andPrintFilteredResultsOn: aStream [
	| lcssAlgo |

	lcssAlgo := MJLongestCommonSubString 
					of: aString
					and: anotherString.
	lcssAlgo computeLCSS.
	(lcssAlgo result size > 0)
			ifTrue: [
				(lcssAlgo result first size > self threshold) 
					ifTrue: [
						lcssAlgo writeResultAsCVSEntryOn: aStream] ].
						
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> findModelClassesFrom: aCollectionOfNames [
	| result |
	
	result := OrderedCollection new.

	aCollectionOfNames do: [:aClassName |
		result addAll: (self targetModel allClasses select: [:class | 
			class mooseName = aClassName ] ) ].

	^ result
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> importActiveRecordClassListFromFile: aFileName [
	| ln stream classNames |

	stream := StandardFileStream fileNamed: aFileName.

	classNames := OrderedCollection new.	
	[(ln := stream nextLine) isNil] whileFalse: [ 
		classNames add: ln].
	
	^classNames
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> importActiveRecordClassListFromactiveRecordsTxt [

	^self findModelClassesFrom: (self importActiveRecordClassListFromFile:  '/Users/fabrizioperin/Development/Pharo/Projects/CollaborazioneArcelli/activeRecords.txt')

]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> targetModel [
	^ targetModel
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> targetModel: aTargetModel [
	targetModel := aTargetModel 
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> threshold [
	^threshold 
]

{ #category : #'as yet unclassified' }
MJCCLCSExperimentsOnAdempiere >> threshold: anInteger [
	threshold := anInteger 
]
