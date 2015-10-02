Class {
	#name : #MooseJEEMenuCustomizations,
	#superclass : #Object,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MooseJEEMenuCustomizations class >> fullScreenEntryMenuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'FullscreenEntryMenu')
		order: 6.0; 
		parent: #System;
		label: 'Fullscreen On/Off';
		action: [ Display toggleFullscreen ];
		withSeparatorAfter
]
