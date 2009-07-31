Extension { #name : #Collection }

{ #category : #'*Moose-JEE' }
Collection >> detect: aBlock ifPresent: okayBlock ifNone: exceptionBlock [
	"detect the element satisfying aBlock1. If we find, we manipulate it based on aBlock2, if not we return the value of aBlock3"

	| element |
	element := self detect: aBlock ifNone: [ ^exceptionBlock value ].
	^okayBlock value: element
]
