Class {
	#name : #MBImportDeploymentDescriptorCmd,
	#superclass : #MBListModelUpdateCommand,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MBImportDeploymentDescriptorCmd >> execute [
	| model streamToLoad |
	streamToLoad := FileList modalFileSelector.
	streamToLoad ifNil: [ ^ self ].

"	tower := FMCompleteTower new.
	tower metamodel addSmalltalkClasses: FAMIXEntity withAllSubclasses.
	tower model importStream: streamToLoad.
	model := tower model.
"
	model := requestor selectedNode element. "MooseModel new importFromMSE: streamToLoad."
	model name: streamToLoad localName.
	model install.
	requestor listChanged.

]

{ #category : #'as yet unclassified' }
MBImportDeploymentDescriptorCmd >> isActive [
	^ (requestor isSelected: target) and: [ requestor selectedNode isKindOf: MBMooseModelNode ]
]

{ #category : #'as yet unclassified' }
MBImportDeploymentDescriptorCmd >> isEnabled [
	^ true
]

{ #category : #'as yet unclassified' }
MBImportDeploymentDescriptorCmd >> label [
	^ 'import XML DD'
]
