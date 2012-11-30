Extension { #name : #MooseModel }

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> allComponentAssociations [
	<navigation: 'All Component Associations'>

	| group |

	group := self allWithType: MEEComponentAssociation ofGroupClass: MEEArchitecturalAssociationGroup. 
	group description: 'All Component Associations'.
	
	^group
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> allComponentContainment [
	<navigation: 'All Component Containment'>

	| group |

	group := self allWithType: MEEContainment.
	group description: 'All Component Containment'.
	
	^group
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> allComponents [
	<navigation: 'All Components'>

	| group |

	group := MEEArchitecturalComponentGroup new addAll: (self allWithSubTypesOf: MEEArchitecturalComponent).
	group description: 'All Components'.
	
	^group
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> clearContainedElementsFromComponents [
	
	^self allComponents do: [:component | component clearContainedElements].
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> clearContainerComponentsFromTypes [
	
	^self allTypes do: [:type | type clearContainerComponents].
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> removeAllComponentAssociations [
	<menuItem: 'Delete all component''s associations' category: 'JEAs Utilities'>

	self  silentlyRemoveAll: self allComponentAssociations.
	
	self cacheMooseGroups
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> removeAllComponentContainment [
	<menuItem: 'Delete all component''s containment' category: 'JEAs Utilities'>

	self clearContainerComponentsFromTypes.
	self clearContainedElementsFromComponents.
	self  silentlyRemoveAll: self allComponentContainment.
	
	self cacheMooseGroups
]

{ #category : #'*moose-jee-architecture-model' }
MooseModel >> removeAllComponents [
	<menuItem: 'Delete all components' category: 'JEAs Utilities'>
	
	self silentlyRemoveAll: self allComponents.
]
