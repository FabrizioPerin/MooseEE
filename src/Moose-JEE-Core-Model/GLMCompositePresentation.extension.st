Extension { #name : #GLMCompositePresentation }

{ #category : #'*moose-jee-core-model' }
GLMCompositePresentation >> roassalWithoutInertia [
	^ self custom: GLMRoassalWithoutInertiaPresentation new
]
