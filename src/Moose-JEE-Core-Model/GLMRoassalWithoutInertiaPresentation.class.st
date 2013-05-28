Class {
	#name : #GLMRoassalWithoutInertiaPresentation,
	#superclass : #GLMRoassalPresentation,
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
GLMRoassalWithoutInertiaPresentation >> view [
	^ view ifNil: [
		| rawView |
		rawView := ROView new.
		rawView @ RODraggable.
		view := ROMondrianViewBuilder initializedView: rawView ]
]
