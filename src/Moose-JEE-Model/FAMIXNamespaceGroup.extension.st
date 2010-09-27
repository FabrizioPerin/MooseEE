Extension { #name : #FAMIXNamespaceGroup }

{ #category : #'*Moose-JEE-Model' }
FAMIXNamespaceGroup >> ranked [
	^(((PageRank new
	referenced: #clientClasses;
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea key ]) asMooseGroup
]
