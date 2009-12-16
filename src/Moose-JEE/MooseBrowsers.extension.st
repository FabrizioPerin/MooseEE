Extension { #name : #MooseBrowsers }

{ #category : #'*Moose-JEE' }
MooseBrowsers >> codeBrowserForJEA [
	
	^ self 
		codeBrowser: 'Java Enterprise'
		withNamespaceTags: 
			[ :namespace |
			( ( namespace types flatCollect: 
				[ :each | 
				each annotationInstances collect: [ :x | x annotationType name ] ]) select: [:x | (x = #transactionScope) 
																											or: [x = #unsafeQuery] ] ) asSet ]
		withClassesTags: 
			[ :class | 
			( ( class annotationInstances collect: [ :each | each annotationType name ] ) select: [:x | (x = #transactionScope) 
																											or: [x = #unsafeQuery] ] ) asSet ]
		withMethodsTags: 
			[ :method | 
			( ( method annotationInstances collect: [ :each | each annotationType name ] ) select: [:x | (x = #transactionScope) 
																											or: [x = #unsafeQuery] ] ) asSet ]
														
]
