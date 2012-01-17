"
self openOn: MooseModel root first 
"
Class {
	#name : #CloneClassesBrowser,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'Moose-JEE-CCProject-Reports'
}

{ #category : #'as yet unclassified' }
CloneClassesBrowser >> buildBrowser [ 
	browser := GLMTabulator new.
	browser title: 'Clone Classes Generic Browser'.
	browser 
		column: [:col |
			col 
				row: #cloneClasses];
		column: [:col | 
			col 
				row: #clonesComparisonGraph;
				row: #sourceCode] span: 3.
	
	browser transmit to: #cloneClasses; andShow: [:a | "a is aGLMCompositePresentation"
		a list
			title: 'Clone Classes';
			display: [ :mm | mm allCloneClasses];
			format: [:cloneClass |
				| stream | 
				stream := ReadWriteStream on: ''.
				cloneClass mooseNameOn: stream.
				stream contents];
			
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ];
			helpMessage:  'Enter a filtering request (e.g., "each numberOfLines > 40")';
			
			act: #update icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Update'.].
	
	browser transmit 
		from: #cloneClasses; 
		to: #clonesComparisonGraph; 
		andShow: [:a | 
			a  eyesee 
				title: 'Clone size vs LoC';
				diagram: [:renderer :cloneClass | 
					cloneClass viewClonesSizeOn: renderer ]].
	
	browser transmit
		from: #clonesComparisonGraph;
		to: #sourceCode;
		andShow: [:a | 
			a text
			title: 'Source code';
			display: [:eyeseeComponent | 
				| source text |
				source := eyeseeComponent model.
				source codeFile isNil
					ifFalse: [ text := source codeFile sourceText ].
				source codeClass isNil
					ifFalse: [ text := source codeClass sourceAnchor completeText ].
				text ] ].
		
	browser transmit 
		to: #sourceCode->#selectionInterval; 
		from: #clonesComparisonGraph; 
		when: [:source | source notNil];
		transformed: [:eyeseeComponent | 
			| source text startIndex endIndex |
			source := eyeseeComponent model.
			source codeFile isNil
					ifFalse: [ text := source codeFile sourceText ].
			source codeClass isNil
					ifFalse: [ text := source codeClass sourceAnchor completeText ].
			startIndex := (text intervalOfLine: source startLine) first.
			endIndex := (text intervalOfLine: source endLine) last.
			startIndex to: endIndex].
	
	^ browser
]

{ #category : #'as yet unclassified' }
CloneClassesBrowser >> filterFunction [
	| cc relevantSources |
	
	cc := MooseModel root first allCloneClasses.
	relevantSources := OrderedCollection new.
	cc
		do: [ :each | 
			relevantSources
				addAll:
					(each sources
						select: [ :source | 
							source codeClass numberOfLinesOfCode = 0
								ifTrue: [ false ]
								ifFalse: [ (source endLine - source startLine) / source codeClass numberOfLinesOfCode > 0.4 ] ]) ].
	relevantSources
]
