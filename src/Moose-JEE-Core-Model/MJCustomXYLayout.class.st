Class {
	#name : #MJCustomXYLayout,
	#superclass : #MOLayout,
	#instVars : [
		'xBlock',
		'yBlock'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #hook }
MJCustomXYLayout >> doExecute: aGraph [ 

	aGraph nodes do: [ :aNodeFigure | aNodeFigure translateTo: (xBlock value: aNodeFigure model) @ (yBlock value: aNodeFigure model) ]
]

{ #category : #accessing }
MJCustomXYLayout >> xBlock [
	^ timeBlock 
]

{ #category : #accessing }
MJCustomXYLayout >> xBlock: aBlock [
	xBlock := aBlock
]

{ #category : #accessing }
MJCustomXYLayout >> yBlock [
	^yBlock
]

{ #category : #accessing }
MJCustomXYLayout >> yBlock: aBlock [
	yBlock := aBlock
]
