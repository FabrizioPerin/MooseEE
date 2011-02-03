Class {
	#name : #MJFAMIXFKGroupingByScriptRelationsReport,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXFKGroupingByScriptRelationsReport >> browser [
	| browser |
	browser := GLMTabulator new.
	browser column: #interestingMaps; column: #visualization.

	browser transmit to: #interestingMaps; andShow: [:a |
		a list
			title: 'Maps';
			display: [:maps | maps]";
			showOnly: 50"].
	
	browser transmit to: #visualization; from: #interestingMaps; andShow: [:a | 
		a mondrian
			title: 'Potential FK relations';
			painting: [:view :map | 
				| scripts tables maps|
				
				scripts  := map from withDeepInvokingScripts.
				scripts := (scripts flatCollect: [:each | each withDeepInvokedScripts]) asSet.
				maps := result select: [:each | scripts includes: each from ].
				
				scripts := (maps flatCollect: [:each | each from withDeepInvokingScripts])asSet.
				tables := (maps collect: [:each | each to]) asSet.
				
				view shape rectangle text: [:script | script container isNil ifTrue: [script name] ifFalse: [script container]]; fontSize: 10; borderColor: Color red.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view node: (scripts remove: map from ifAbsent: [Error signal: 'Element not found' ]).
	
				view shape rectangle text: [:script | script container isNil ifTrue: [script name] ifFalse: [script container]]; fontSize: 10.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: scripts.
				
				view shape rectangle text: [:table | table name]; fontColor: Color cyan.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: tables.

				view shape line color: Color black.
				view edges: maps from: #from to: #to.
				
				view shape line color: Color lightGray lighter.
				view edges: self model allInvocations from: #sender toAll: #candidates.
				
				
				view horizontalDominanceTreeLayout]].

  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXFKGroupingByScriptRelationsReport >> computeResult [
	
	| maps lonelyMaps interestingMaps |
	
	maps := self model allMaps select: [:map | map from isKindOf: PXSScript].
	lonelyMaps := maps select: [:each | each from withDeepInvokingScripts size = 1].
	interestingMaps := maps reject: [:each | each from withDeepInvokingScripts size = 1].
	
	^interestingMaps
]

{ #category : #'as yet unclassified' }
MJFAMIXFKGroupingByScriptRelationsReport >> explanation [ 
  ^ 'List of data base''s columns that have a levensthein distance among them below 
In the first panel there is the list of column''s distances in a form:
	 
column''s table name>>column name -> column''s table name>>column name (distance)
	
The columns on the left of the association are primary key while the columns on the right don''t have any foreign key constraint defined.
	
By clicking on an entry another panel with a visualization will open showing the tables containing columns that have been found with a distance below the threshold. The columns in blu are primary key. The visualized element are choose like this: 
- pickup the column at the left side of the association
- pickup all the associations that have the selected column as left entity or right entity.
	
E.g. Considering a report with this two associations: TAB1>>COL1 -> TAB2>>COL2 and TAB3>>COL3 -> TAB1COL1. 
By selecting the first association in the visualization you will see TAB3 with the COL3 inside on the left part, TAB1 with the COL1 inside in the middle and TAB2 with the COL2 inside on the right.'
]

{ #category : #'as yet unclassified' }
MJFAMIXFKGroupingByScriptRelationsReport >> label [ 
  ^ 'Foreign Key recovery'
]
