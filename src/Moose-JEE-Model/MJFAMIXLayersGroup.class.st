Class {
	#name : #MJFAMIXLayersGroup,
	#superclass : #MJGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLayersGroup class >> annotation [

	<MSEClass: #LayersGroup super: #MJGroup>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXLayersGroup >> viewSystemComplexityByLayerOn: view [
	

"view nodes: beans using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder )
"

]
