Class {
	#name : #MEEArchitecturalComponentGroup,
	#superclass : #MEEArchitecturalGroup,
	#category : #'Moose-JEE-Architecture-Model'
}

{ #category : #'as yet unclassified' }
MEEArchitecturalComponentGroup class >> annotation [
	<MSEClass: #ArchitecturalComponentGroup super: #MEEArchitecturalGroup>
	<package: #MEE>
	^self
]

{ #category : #accessing }
MEEArchitecturalComponentGroup >> numberOfLinesOfCodeOfTheComponentElements [
	| sum |
	
	sum := 0.
	self do: [ :component | sum := sum + component numberOfLinesOfCode ].

	^ sum
]
