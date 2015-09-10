Extension { #name : #Number }

{ #category : #'*moose-jee-wizard' }
Number >> truncateAt: aDigit [
	"Answer the next multiple of aNumber toward zero that is nearest the receiver.
	Examples:
               3.1479 truncateAt: 2 3.147 
               3.1479 truncateAt: 2 -> 3.14
               1923 truncateAt: 2 -> 1923
               3.1479 truncateAt: 0 -> 3.0
               -3.1479 truncateAt: 3 -> -3.147"

	^(self * (10 raisedTo: aDigit)) integerPart / (10 raisedTo:aDigit)
]
