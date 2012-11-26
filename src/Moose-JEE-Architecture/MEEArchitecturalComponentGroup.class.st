Class {
	#name : #MEEArchitecturalComponentGroup,
	#superclass : #MEEArchitecturalGroup,
	#category : #'Moose-JEE-Architecture'
}

{ #category : #'as yet unclassified' }
MEEArchitecturalComponentGroup class >> annotation [
	<MSEClass: #MEEArchitecturalComponentGroup super: #MooseGroup>
	<package: #'Babel-Model'>
	^self
]

{ #category : #accessing }
MEEArchitecturalComponentGroup >> numberOfLinesOfCodeOfTheComponentElements [
	| sum |
	
	sum := 0.
	self do: [ :component | sum := sum + component numberOfLinesOfCode ].

	^ sum
]
