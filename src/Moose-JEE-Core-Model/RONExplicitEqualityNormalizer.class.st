Class {
	#name : #RONExplicitEqualityNormalizer,
	#superclass : #RONExplicitIdentityNormalizer,
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
RONExplicitEqualityNormalizer >> initialize [
	super initialize.
	colorIndex := 6.
	dictionary := Dictionary new.
]

{ #category : #'as yet unclassified' }
RONExplicitEqualityNormalizer >> nextColor [

	colorIndex := colorIndex + 2 \\ Color colorNames size + 1.
	^Color perform: (Color colorNames at: colorIndex)
]
