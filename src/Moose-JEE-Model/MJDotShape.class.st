Class {
	#name : #MJDotShape,
	#superclass : #MOFixedRectangleShape,
	#category : #'Moose-JEE-Model'
}

{ #category : #public }
MJDotShape >> computeHeightFor: aNode [
	| h |
	h := 1.
	^ (self height moValue: aNode model) asInteger max: h
]

{ #category : #public }
MJDotShape >> computeWidthFor: aNode [
	| w |
	w := 1.
	^ (self width moValue: aNode model) asInteger max: w
]
