Extension { #name : #MooseModel }

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> allDataLayer [
	"it should always be one"
	^self allWithType: MJFAMIXDataLayer
]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> allLayers [
	<navigation: 'All Layers'>

	| group |

	group := MJFAMIXLayerGroup new addAll: self allPresentationLayer.
	group addAll: self allLogicLayer.
	group addAll: self allDataLayer.
	group addAll: self allServiceLayer.
	
	group description: 'All Standard Layers'.
	^group
]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> allLogicLayer [

	^self allWithType: MJFAMIXLogicLayer "asMetaDescription"
]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> allPresentationLayer [

	^self allWithType: MJFAMIXPresentationLayer "asMetaDescription"
]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> allServiceLayer [

	^self allWithType: MJFAMIXServiceLayer "asMetaDescription"
]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> cleanUpLayers [
	<menuItem: 'Clean up all layers' category: 'JEAs Utilities'>
	
	MJFAMIXLayer allSubclasses do: [:each | self silentlyRemoveAll: (self allWithType: each)].
	

]

{ #category : #'*moose-jee-tiers-model' }
MooseModel >> populateSystemLayers [
	<menuItem: 'Populate system layers' category: 'JEAs Importers'>

	|  question strategy |

	question := UITheme builder questionWithoutCancel: 'Do you want to clean up previously created layers?'.
	question ifTrue: [self cleanUpLayers].   

	strategy := UITheme builder chooseDropList: 'Choose the strategy to populate the layers ' list: (MJLayeringStrategy allSubclasses).
	
	strategy  isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			| layeringStrategy |			
			layeringStrategy := strategy on: self.
			layeringStrategy instanciateLayers.].
]
