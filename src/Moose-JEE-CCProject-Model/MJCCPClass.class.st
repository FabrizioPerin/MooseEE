Class {
	#name : #MJCCPClass,
	#superclass : #FAMIXEntity,
	#instVars : [
		'id',
		'numberOfLines',
		'numberOfFragments',
		'sources'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPClass >> addAllSources: aCollectionOfMJCCPSource [
	self sources addAll: aCollectionOfMJCCPSource. 
]

{ #category : #accessing }
MJCCPClass >> addSource: aMJCCPSource [
	self sources add: aMJCCPSource. 
]

{ #category : #accessing }
MJCCPClass >> id [
	^ id
]

{ #category : #accessing }
MJCCPClass >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MJCCPClass >> initialize [
	super initialize.
 
	sources := FMMultivalueLink on: self opposite: #cloneClass:.
]

{ #category : #accessing }
MJCCPClass >> mooseNameOn: stream [ 

	stream nextPutAll: 'id: '.
	stream nextPutAll: self id asString.
	stream nextPutAll: '#ofFragments: '.
	stream nextPutAll: self numberOfFragments asString.
	stream nextPutAll: '#ofLine '.
	stream nextPutAll: self numberOfLines asString.
	stream nextPutAll: ' (Clone Class)'.
	
	^stream
]

{ #category : #accessing }
MJCCPClass >> numberOfFragments [
	^ numberOfFragments
]

{ #category : #accessing }
MJCCPClass >> numberOfFragments: anObject [
	numberOfFragments := anObject
]

{ #category : #accessing }
MJCCPClass >> numberOfLines [
	^ numberOfLines
]

{ #category : #accessing }
MJCCPClass >> numberOfLines: anObject [
	numberOfLines := anObject
]

{ #category : #accessing }
MJCCPClass >> printOn: stream [ 

	stream nextPutAll: 'id: '.
	stream nextPutAll: self id asString.
	stream nextPutAll: ' #fragments: '.
	stream nextPutAll: self numberOfFragments asString.
	stream nextPutAll: ' (Clone Class)'.
	
	^stream
]

{ #category : #accessing }
MJCCPClass >> sources [
	<MSEProperty: #sources type: #MJCCPSource opposite: #cloneClass> <multivalued> <derived>
	<MSEComment: 'Contains all peaces of a clone class'>
	
	^ sources
]

{ #category : #accessing }
MJCCPClass >> viewClonesSize [
	<menuItem: 'Clones size' category: 'JEE Visualizations'> 
	| aChartRenderer |

	aChartRenderer := ESDiagramRenderer new.
	self viewClonesSizeOn: aChartRenderer.
	aChartRenderer open.
]

{ #category : #accessing }
MJCCPClass >> viewClonesSizeOn: aChart [
	| diag1 diag2 |
	
	diag1 := ESVerticalBarDiagram new
		identifier: [ :source | 
			source codeClass isNil
				ifFalse: [ source codeClass name removeSuffix: '.java'].
			source codeFile isNil
				ifFalse: [ source codeFile name removeSuffix: '.java' ] ];
		rotatedLabels: true;
		y: [ :source |
			| text |

			source codeClass isNil
				ifFalse: [text := source codeClass sourceAnchor completeText. ].
			source codeFile isNil
				ifFalse: [text := source codeFile sourceText. ].
			 
			(text isNil not and: [text contents lineCount > 0]) 
				ifTrue: [text contents lineCount]
				ifFalse: [source codeClass numberOfLinesOfCode]];
		regularAxis;
		models: self sources;
		yAxisLabel: 'LoC';
		yourself.
	
	diag2 := ESVerticalBarDiagram new
		y: [ :source | source endLine - source startLine ];
		valueAxisLine;
		gapFraction: 2 / 3;
		preferredAxisMaxY: diag1 values max;
		rightYAxis;
		defaultColor: Color green;
		axisColor: Color green;
		yAxisLabel: 'Clone Size';
		models: self sources;
		yourself.
	
	(aChart compositeDiagram)
		add: diag1;
		add: diag2;
		yPadding: 30;
		height: 400;
		width: 500.
	
	aChart interaction popupText: #yourself.
	
	
]
