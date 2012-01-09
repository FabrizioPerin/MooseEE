Extension { #name : #MooseModel }

{ #category : #'*moose-jee-ccproject-model' }
MooseModel >> allCloneClasses [
	<navigation: 'All Clone Classes'>
	
	| group |
	
	group := self allWithType: MJCCPClass. "ofGroupClass: MJFAMIXMessageDrivenBeanGroup."
	group description: 'All Clone Classes'.

	^group
]

{ #category : #'*moose-jee-ccproject-model' }
MooseModel >> allCloneSources [
	<navigation: 'All Clone Sources'>
	
	| group |
	
	group := self allWithType: MJCCPSource. "ofGroupClass: MJFAMIXMessageDrivenBeanGroup."
	group description: 'All Clone Sources'.

	^group
]

{ #category : #'*moose-jee-ccproject-model' }
MooseModel >> cleanAllClonesInfo [
	<menuItem: 'Clean up all clones info' category: 'JEAs Utilities'>

	self silentlyRemoveAll: (self allWithType: MJCCPSource).
	self silentlyRemoveAll: (self allWithType: MJCCPClass).
	self silentlyRemoveAll: (self allWithType: MJCCPClones).
	self silentlyRemoveAll: (self allWithType: MJCCPClassinfo).
	self silentlyRemoveAll: (self allWithType: MJCCPSysteminfo).

	self allClasses do: #cleanAllCloneSources.

	Smalltalk garbageCollect.
	
]
