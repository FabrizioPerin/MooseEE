Extension { #name : #FAMIXPackageGroup }

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXPackageGroup >> ranked [
	^(((PageRank new
	referenced: #clientClasses;
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea key ]) asMooseGroup
]
