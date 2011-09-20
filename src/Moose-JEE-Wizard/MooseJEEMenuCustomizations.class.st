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
		icon: MooseIcons mooseSearch;
		action: [Display fullScreen: (Display isFullScreen not) ];
		withSeparatorAfter
]
