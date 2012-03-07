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
MJCCLCSExperiments >> computeLCSSAndWriteResultsOnCSVFile: aFileName [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: aFileName , '.csv'.
	MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	MooseCustomTask 
		runWithProgress: [ :bar | 
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: (tables at: firstIndex) name and: (tables at: secondIndex) name andPrintFilteredResultsOn: aStream.
							bar increment ] ] ]
		description:  'Computing LCSS among all model tables' 
		length: ((tables size * tables size) / 2) asInteger.
	
	aStream close.
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
MJCCLCSExperiments >> exp1ComputeLCSSAndWriteResultsOnCSVFile: aFileName [
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
							| lcs |
							lcs := MJLongestCommonSubSequence of: (tables at: firstIndex) name and: (tables at: secondIndex) name.
							lcs computelcsLenght.
							lcs writeResultAsCVSEntryOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1LCSRun [

	"WARNING!!! Modify this script accordingly with the sequence in which the databases are loaded in Moose"

	| lcsExps |
	
	lcsExps := MJCCLCSExperiments on: MooseModel root first.
	lcsExps exp1OnTunProdAgricDBCleaned.
	
	lcsExps := MJCCLCSExperiments on: MooseModel root second.
	lcsExps thresholdSize: 3.
	lcsExps exp1OnDump2012020ep.
	
	lcsExps := MJCCLCSExperiments on: MooseModel root third.
	lcsExps thresholdSize: 4.
	lcsExps exp1OnAdempiere.
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1OnAdempiere [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: 'Tun-Prod-AgricDBCleanedEXP1.csv'.
	MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
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
							| lcs |
							lcs := MJLongestCommonSubSequence of: (tables at: firstIndex) name  and: (tables at: secondIndex) name.
							lcs computelcsLenght.
							lcs writeResultAsCVSEntryOn: aStream.
							counter := counter + 1.
							bar value: counter ] ].
			aStream close ]
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1OnDump2012020ep [

	self exp1ComputeLCSSAndWriteResultsOnCSVFile: 'Dump2012020epEXP1'.

]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1OnTunProdAgricDBCleaned [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed: 'Tun-Prod-AgricDBCleanedEXP1.csv'.
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
							| lcs |
							lcs := MJLongestCommonSubSequence of: ((tables at: firstIndex) name removePrefix: 'mydb.') and: ((tables at: secondIndex) name removePrefix: 'mydb.').
							lcs computelcsLenght.
							lcs writeResultAsCVSEntryOn: aStream.
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
	
	MooseCustomTask 
		runWithProgress: [ :bar | 
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: (tables at: firstIndex) name and: (tables at: secondIndex) name andPrintFilteredResultsOn: aStream.
							bar increment ] ] ]
		description:  'Computing LCSS among all model tables' 
		length: ((tables size * tables size) / 2) asInteger.
	
	aStream close 
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSOnDump2012020ep [

	self computeLCSSAndWriteResultsOnCSVFile:  'Dump2012020epEXP2'.

]

{ #category : #amongFields }
MJCCLCSExperiments >> exp2LCSSOnTunProdAgricDBCleaned [
	| result distances aStream fileName tables |
	
	aStream := MultiByteFileStream forceNewFileNamed:  'Tun-Prod-AgricDBCleanedEXP2.csv'.
	MJLongestCommonSubString writeCVSEntryHeaderOn: aStream.
	tables := targetModel allTables.
	
	MooseCustomTask 
		runWithProgress: [ :bar | 
			(1 to: tables size)
				do: [ :firstIndex | 
					((firstIndex + 1) to: tables size)
						do: [ :secondIndex |
							self computeLCSSOf: ((tables at: firstIndex) name removePrefix: 'mydb.') and: ((tables at: secondIndex) name removePrefix: 'mydb.') andPrintFilteredResultsOn: aStream.
							bar increment ] ] ]
		description:  'Computing LCSS among all model tables' 
		length: ((tables size * tables size) / 2) asInteger.

	aStream close
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
	lcsExps thresholdSize: 4.
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
