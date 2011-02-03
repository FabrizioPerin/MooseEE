Extension { #name : #MooseGroup }

{ #category : #'*moose-jee-reports' }
MooseGroup >> fullyConnectGroupElementsThroughDependencies [
	
	| sources targets dependencies |
	
	sources := self.
	targets := self.
	dependencies := OrderedCollection new.
	
	(1 to: sources size) do: [:sourceIndex | 
		((sourceIndex + 1) to: targets size) do: [:targetIndex |
			| dependency |
			dependency := MJFAMIXDerivedDependency new.
			dependency source: (sources at: sourceIndex).
			dependency target: (targets at: targetIndex).
			(sources at: sourceIndex) addOutgoingDerivedDependency: dependency.
			(targets at: targetIndex) addIncomingDerivedDependency: dependency.
			
			dependencies add: dependency.]].
	
	self mooseModel withoutAnnounceAddAll: dependencies.
]
