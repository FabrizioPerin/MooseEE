Class {
	#name : #MooseJEEHelp,
	#superclass : #CustomHelp,
	#category : #'Moose-JEE-Help'
}

{ #category : #pages }
MooseJEEHelp class >> Introduction [
	"This method was automatically generated. Edit it using:"
	"MooseJEEHelp edit: #Introduction"
	^HelpTopic
		title: 'Introduction'
		contents: 
'This help will give explanations about MooseJEE, the extension of Moose to analyze etherogenous applications.!' readStream nextChunkText
]
