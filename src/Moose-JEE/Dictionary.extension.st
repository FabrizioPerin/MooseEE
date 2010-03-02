Extension { #name : #Dictionary }

{ #category : #'*Moose-JEE' }
Dictionary >> determinAGroupNumber: anInteger [
	"this method recursively determin the minimum value inside a list of elements inside a dictionary "
	
	| value next |

	value := self at: anInteger ifAbsent: [^nil].
	value isNil 
		ifTrue: [^anInteger ]
		ifFalse: [ ^value min: (self determinAGroupNumber: value)] 
]

{ #category : #'*Moose-JEE' }
Dictionary >> updateGroupNumberWith: anInteger [
	"this method assign a value at all keys found into the dictionary"

	^ self keysDo: [:key |  self at: key put: anInteger ]
]
