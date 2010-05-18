Extension { #name : #Collection }

{ #category : #'*Moose-JEE-Model' }
Collection >> detect: aBlock ifPresent: okayBlock ifNone: exceptionBlock [
	"detect the element satisfying aBlock1. If we find, we manipulate it based on aBlock2, if not we return the value of aBlock3"

	| element |
	element := self detect: aBlock ifNone: [ ^exceptionBlock value ].
	^okayBlock value: element
]

{ #category : #'*Moose-JEE-Model' }
Collection >> flatten [
	"Recursively collect each non-collection element of the receiver and its descendant
	collections.  Please note, this implementation assumes that strings are to be treated
	as objects rather than as collection."

	^self recursiveCollect:  [ :each ]


]

{ #category : #'*Moose-JEE-Model' }
Collection >> recursiveCollect: aBlock [
	"Recursively collect each non-collection element of the receiver and its descendant
	collections.  Please note, this implementation assumes that strings are to be treated
	as objects rather than as collection."

	| stream |
	stream := self species new writeStream.
	self recursiveDo: [ :each | stream nextPut: (aBlock value: each) ].
	^stream contents


]

{ #category : #'*Moose-JEE-Model' }
Collection >> recursiveDo: aBlock [

	"Recursively evaluate aBlock for each non-collection element of the receiver and its
	descendant collections.  Please note, this implementation assumes that strings are
	to be treated as objects rather than as collection."

	self do: [ :each |
					each isString 
						ifTrue: [ aBlock value: each ]
						ifFalse: [ each isCollection
											ifTrue: [ each recursiveDo: aBlock ]
											ifFalse: [ aBlock value: each ]]].


]
