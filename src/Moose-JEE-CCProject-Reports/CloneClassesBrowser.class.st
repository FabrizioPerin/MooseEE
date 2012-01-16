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
"	self browserActions."
	browser title: 'Clone Classes Generic Browser'.
	browser column: #cloneClasses; column: #clonesComparisonGraph span: 3.
	browser transmit to: #cloneClasses; andShow: [:a | 
		(a list)
			title: 'Clone Classes';
			display: [ :mm | mm allCloneClasses];
			format: [:cloneClass |
				| stream | 
				stream := ReadWriteStream on: ''.
				cloneClass mooseNameOn: stream.
				stream contents];
			act: #update icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Update' ].
	browser transmit 
		from: #cloneClasses; 
		to: #clonesComparisonGraph; 
		"transformed: [:reference | 
			| parser | 
			reference isNil ifFalse: [
				parser := PXSScriptLogParser new.
				parser parse: reference readStream contents asString.
				reference -> parser top] ]; "
		andShow: [:a | 
			a  eyesee 
				title: 'Clone size vs LoC';
				diagram: [:renderer :cloneClass | 
					cloneClass viewClonesSizeOn: renderer ]].			
	^ browser
]
