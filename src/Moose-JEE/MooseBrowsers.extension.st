Extension { #name : #MooseBrowsers }

{ #category : #'*Moose-JEE' }
MooseBrowsers >> codeBrowserForJEA [
	
	^ self 
		codeBrowserForJEA: 'Java Enterprise'
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

{ #category : #'*Moose-JEE' }
MooseBrowsers >> codeBrowserForJEA: title withNamespaceTags: namespaceTagsBlock withClassesTags: classTagsBlock withMethodsTags: methodTagsBlock [
	| browser text |
	browser := GLMTabulator new.
	browser title: title.
	browser
		row:
				[ :r | 
					r
						column: #packages;
						column: #classes;
						column: #methods ];
		row: #details.
	browser
		showOn: #packages;
		using:
				[ (browser tree)
						display: [ :model | model allNamespaces select: [ :each | each parentScope isNil ] ];
						children: [ :each | each childScopes ];
						tags: [ :namespace | namespaceTagsBlock value: namespace ];
						format: #mooseName;
						actions: [ :tree | tree selection mooseInterestingEntity mooseFinderActions ];
						filterOn: [ :string :each | string match: each name ] ].
	browser
		showOn: #classes;
		from: #packages;
		using:
				[ (browser tree)
						display: [ :namespace | namespace types ];
						format:
								[ :class | class isStub ifTrue: [ Text string: class name attribute: TextEmphasis italic ] ifFalse: [ Text fromString: class name ] ];
						tags: [ :class | classTagsBlock value: class ];
						actions: [ :tree | tree selection mooseInterestingEntity mooseFinderActions ] ].
	browser
		showOn: #methods;
		from: #classes;
		using:
				[ (browser tree)
						title: 'Methods' translated;
						display: [ :class | class methods ];
						format: #name;
						tags: [ :method | methodTagsBlock value: method ];
						actions: [ :tree | tree selection mooseInterestingEntity mooseFinderActions ].
					(browser mondrian)
						title: 'Blueprint' translated;
						painting: [ :view :class | class viewBlueprintOn: view ] ].
	browser
		showOn: #details;
		from: #methods;
		using:
				[ browser text display:
							[ :method | 
							text := method sourceText.
							text isEmpty ifTrue: [ 'No source available' ] ifFalse: [ text ] ] ].
	browser
		showOn: #details;
		from: #classes;
		using:
				[ browser text display:
							[ :cls | 
							text := cls sourceText.
							text isEmpty ifTrue: [ 'No source available' ] ifFalse: [ text ] ].
					(browser mondrian)
						title: 'Transaction Flow';
						painting: [ :view :class | 
										(FAMIXClassGroup withAll: (((class withDeepInvokingClasses) union: (class withDeepInvokedClasses)) select:[:each | each isStub not ])
										) viewMethodsWithTransactionFlowWithoutEllipseShapesOn: view ] 
				].
	^ browser
]
