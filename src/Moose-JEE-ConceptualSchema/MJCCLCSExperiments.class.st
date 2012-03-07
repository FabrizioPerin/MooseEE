Class {
	#name : #MJCCLCSExperiments,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'thresholdSize'
	],
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCCLCSExperiments class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #amongFields }
MJCCLCSExperiments >> computeLCSSOf: aString and: anotherString andPrintFilteredResultsOn: aStream [
	| lcssAlgo |

	lcssAlgo := MJLongestCommonSubString 
					of: aString
					and: anotherString.
	lcssAlgo computeLCSS.
	(lcssAlgo result size > 0)
			ifTrue: [
				(lcssAlgo result first size >= self thresholdSize) 
					ifTrue: [
						lcssAlgo writeResultAsCVSEntryOn: aStream] ].
						
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1OnDump2012020ep [

	self exp1WriteResultsOnCSVFileName: 'Dump2012020ep'.

]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1OnTunProdAgricDBCleaned [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: 'result/Tun-Prod-AgricDBCleaned.csv'.
	MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	UIManager default
		displayProgress: 'Computing LCS among all model tables'
		at: Sensor cursorPoint
		from: 1
		to: ((tables size * tables size) / 2) asInteger
		during: [ :bar | 
			| counter |
			counter := 1.
			bar value: counter.
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: ((tables at: firstIndex) name removePrefix: 'mydb.') and: ((tables at: secondIndex) name removePrefix: 'mydb.') andPrintFilteredResultsOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1WriteResultsOnCSVFileName: aFileName [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: aFileName , '.csv'.
	MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	UIManager default
		displayProgress: 'Computing LCS among all model tables'
		at: Sensor cursorPoint
		from: 1
		to: ((tables size * tables size) / 2) asInteger
		during: [ :bar | 
			| counter |
			counter := 1.
			bar value: counter.
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: (tables at: firstIndex) name and: (tables at: secondIndex) name andPrintFilteredResultsOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSComputeAndWriteResultsOnCSVFile: aFileName [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: aFileName , '.csv'.
	MJLongestCommonSubString writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	UIManager default
		displayProgress: 'Computing LCS among all model tables'
		at: Sensor cursorPoint
		from: 1
		to: ((tables size * tables size) / 2) asInteger
		during: [ :bar | 
			| counter |
			counter := 1.
			bar value: counter.
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex | 
							| lcssAlgo |
							self computeLCSSOf: (tables at: firstIndex) name and: (tables at: secondIndex) name andPrintFilteredResultsOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSOnAdempiere [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed:  'AdempiereEXP2.csv'.
	MJLongestCommonSubString writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables reject: [:each | each name endsWith: '_trl'].
	
	UIManager default
		displayProgress: 'Computing LCS among all model tables'
		at: Sensor cursorPoint
		from: 1
		to: ((tables size * tables size) / 2) asInteger
		during: [ :bar | 
			| counter |
			counter := 1.
			bar value: counter.
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: (tables at: firstIndex) name and: (tables at: secondIndex) name andPrintFilteredResultsOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSOnDump2012020ep [

	self exp2LCSSComputeAndWriteResultsOnCSVFile:  'Dump2012020epEXP2'.

]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSOnTunProdAgricDBCleaned [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed:  'Tun-Prod-AgricDBCleanedEXP2.csv'.
	MJLongestCommonSubString writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	UIManager default
		displayProgress: 'Computing LCS among all model tables'
		at: Sensor cursorPoint
		from: 1
		to: ((tables size * tables size) / 2) asInteger
		during: [ :bar | 
			| counter |
			counter := 1.
			bar value: counter.
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: ((tables at: firstIndex) name removePrefix: 'mydb.') and: ((tables at: secondIndex) name removePrefix: 'mydb.') andPrintFilteredResultsOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSRun [

	"WARNING!!! Modify this script accordingly with the sequence in which the databases are loaded in Moose"

	| lcsExps |
	
	lcsExps := MJCCLCSExperiments on: MooseModel root first.
	lcsExps thresholdSize: 3.
	lcsExps exp2LCSSOnTunProdAgricDBCleaned.
	
	lcsExps := MJCCLCSExperiments on: MooseModel root second.
	lcsExps thresholdSize: 3.
	lcsExps exp2LCSSOnDump2012020ep.
	
	lcsExps := MJCCLCSExperiments on: MooseModel root third.
	lcsExps thresholdSize: 3.
	lcsExps exp2LCSSOnAdempiere.
]

{ #category : #accessing }
MJCCLCSExperiments >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJCCLCSExperiments >> targetModel: anObject [
	targetModel := anObject
]

{ #category : #accessing }
MJCCLCSExperiments >> thresholdSize [
	^thresholdSize
]

{ #category : #accessing }
MJCCLCSExperiments >> thresholdSize: anInteger [
	thresholdSize := anInteger.
]
