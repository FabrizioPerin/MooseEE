Class {
	#name : #GLMRoassalWithoutInertiaPresentation,
	#superclass : #GLMRoassal2Presentation,
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
GLMRoassalWithoutInertiaPresentation >> view [
	^ view ifNil: [
		| rawView |
		rawView := RTView new.
		rawView @ RTDraggable.
		view := RTMondrian initializedView: rawView ]
]
