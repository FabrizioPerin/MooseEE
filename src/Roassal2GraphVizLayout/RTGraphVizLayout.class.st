"
GraphViz is a well know library to layout graphs.
In order to use ROGraphVizLayout, you need to install on your machine GraphViz:
http://www.graphviz.org/Download..php

A Mondrian example for the layout:
-=-=-=-=
view shape rectangle size: #yourself.
view nodes: (1 to: 100).
view edgesFrom: [ :x | x // 5 ].
view layout: (ROGraphVizLayout new).
-=-=-=-=

A RTGraphVizLayout is xxxxxxxxx.

Instance Variables
	extent:		<Object>
	ids:		<Object>
	layout:		<Object>
	root:		<Object>
	useSplines:		<Object>

extent
	- xxxxx

ids
	- xxxxx

layout
	- xxxxx

root
	- xxxxx

useSplines
	- xxxxx

"
Class {
	#name : #RTGraphVizLayout,
	#superclass : #RTLayout,
	#instVars : [
		'root',
		'extent',
		'ids',
		'layout',
		'useSplines'
	],
	#category : #Roassal2GraphVizLayout
}

{ #category : #'available layout types' }
RTGraphVizLayout class >> circo [
	^ self new circo; yourself
]

{ #category : #'available layout types' }
RTGraphVizLayout class >> dot [
	^ self new dot; yourself
]

{ #category : #testing }
RTGraphVizLayout class >> isAbstract [
	^ false
]

{ #category : #'available layout types' }
RTGraphVizLayout class >> neato [
	^ self new neato; yourself
]

{ #category : #'available layout types' }
RTGraphVizLayout class >> sfdp [
	^ self new sfdp; yourself
]

{ #category : #'available layout types' }
RTGraphVizLayout class >> twopi [
	^ self new twopi; yourself
]

{ #category : #layout }
RTGraphVizLayout >> applyLayoutToNodes: aCollection with: positions [
	| minX minY minXId minYId nodePositions |
	nodePositions := positions associations select: [:assoc | assoc key isNumber].
	nodePositions isEmpty ifTrue: [^ self ].
	minX := nodePositions first value x.
	minY := nodePositions first value y.
	nodePositions do: [:assoc |
			assoc value x < minX ifTrue: [ minX := assoc value x ].
			assoc value y < minY ifTrue: [ minY := assoc value y ] ].
	aCollection do: [ :each |
		each translateTo: (positions at: (self ids at: each model)) - (minX @ minY).
"		each translateBy: ((each bounds width / 2) negated @ (each bounds height / 2) negated)
"	]
]

{ #category : #layout }
RTGraphVizLayout >> callGraphViz [
	| source target process d |

	d := Delay forMilliseconds: 4000.
	
	source := (Smalltalk imageDirectory / 'mondrian_dot') fullName .
	target := (Smalltalk imageDirectory / 'mondrian_plain') fullName.	
	
	OSProcess isWindows
	ifTrue: [		
		#( 'C:\Program Files (x86)\Graphviz2.30\bin' 'C:\Program Files\Graphviz2.30\bin') 
			do: [ :each |
				(each asFileReference / self layout , 'exe' ) exists ifTrue: [
					process := OSProcess command: '"' , each , '\', self layout, '.exe' , '" -q -Tplain "' , source , '" -o "' , target , '"'.
					[process notNil and: [ (Smalltalk imageDirectory / 'mondrian_plain') exists "process isComplete" ] ] 
						whileFalse: [ d wait ].
					process closeStreams.
					process finalize.
					process complete.
					^target ] ] ]
	ifFalse: [
		#( '.' '/bin' '/usr/bin' '/usr/local/bin' '/Applications/GraphViz.app/Contents/MacOS' ) 
			do: [ :each |
				(each asFileReference / self layout) exists ifTrue: [
					process := OSProcess waitForCommand: '"' , each , '/', self layout,'" -q -Tplain "' , source , '" -o "' , target , '"'.
					(process notNil and: [ Delay forMilliseconds: 50. process isComplete ])
						ifTrue: [ ^ process ] ] ] ].
	
	self inform: 'Unable to run GraphViz. Please check that it is available through the command line.'.
	^ nil
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> circo [
	"circo - circular layout, after Six and Tollis 99, Kauffman and Wiese 02. This is suitable for certain diagrams of multiple cyclic structures such as certain telecommunications networks."
	^ self layout: 'circo'
]

{ #category : #layout }
RTGraphVizLayout >> createDotFileNodes: nodes connections: connections [
	
	| dot |
	
	dot := FileStream fileNamed: 'mondrian_dot'.
	
	dot nextPutAll: 'digraph {'; cr;
		nextPutAll: 'splines= ', self useSplines asString, ';'; cr.
	
	self ids at: root ifPresent: [ :value |
		dot nextPutAll: 'root='; nextPutAll: value asString; nextPut: $;; cr. ].

	"write nodes to file, using the values of the identity hashes as the node name"	
	nodes do: [ :each |
		dot nextPutAll: (self ids at: each model) asString,
						' [ width = ', (each bounds width / self scaleFactor) asString,
						', height = ', (each bounds height / self scaleFactor) asString,
						', shape=box, fixedsize=true ];'; cr.
	].

	"write connections to file"
	connections do: [ :each |
		dot nextPutAll: (self ids at: each source model) asString.
		dot nextPutAll: ' -> '.
		dot nextPutAll: (self ids at: each target model) asString.
		dot nextPutAll: ' [ arrowhead=none ];'; cr.
	].
	
	dot nextPutAll: '}'.
	
	dot flush.
	dot close.
]

{ #category : #layout }
RTGraphVizLayout >> createIdMapping: nodes [
	| idMap counter |
	
	idMap := IdentityDictionary new.

	counter := 1.
	nodes do: [ :each |
		idMap at: each model put: counter.
		counter := counter + 1.
	].

	^ idMap
]

{ #category : #'default values' }
RTGraphVizLayout >> defaultFromPositions [
	^ #(center)
]

{ #category : #'default values' }
RTGraphVizLayout >> defaultToPositions [
	^ #(center)
]

{ #category : #'as yet unclassified' }
RTGraphVizLayout >> doExecute: elements [
	"do nothing because this layout is more special than the rest of the layouts due
	to the external computation through dot.
	
	we still have to overwrite this method because Roassal tests for this contract"
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> dot [
	"dot - ``hierarchical'' or layered drawings of directed graphs. The layout algorithm aims edges in the same direction (top to bottom, or left to right) and then attempts to avoid edge crossings and reduce edge length."
	^ self layout: 'dot'
]

{ #category : #accessing }
RTGraphVizLayout >> extent [
	^ extent
]

{ #category : #accessing }
RTGraphVizLayout >> extent: anObject [
	extent := anObject
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> fdp [
	"fdp - ``spring model'' layouts similar to those of neato, but does this by reducing forces rather than working with energy. Fdp implements the Fruchterman-Reingold heuristic including a multigrid solver that handles larger graphs and clustered undirected graphs."
	^ self layout: 'fdp'
]

{ #category : #accessing }
RTGraphVizLayout >> ids [
	^ ids
]

{ #category : #accessing }
RTGraphVizLayout >> ids: anObject [
	ids := anObject
]

{ #category : #initialize }
RTGraphVizLayout >> initialize [
	super initialize.

	self layout: 'fdp'.
	self useSplines: false.
]

{ #category : #accessing }
RTGraphVizLayout >> layout [
	^ layout
]

{ #category : #accessing }
RTGraphVizLayout >> layout: anObject [
	layout := anObject
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> neato [
	"neato - ``spring model'' layouts. Neato attempts to minimize a global energy function, which is equivalent to statistical multi-dimensional scaling. The solution is achieved using stress majorization, though the older Kamada-Kawai algorithm, using steepest descent, is also available. fdp implements the Fruchterman-Reingold heuristic including a multigrid solver that handles larger graphs and clustered undirected graphs."
	^ self layout: 'neato'
]

{ #category : #layout }
RTGraphVizLayout >> on: elements edges: edgeElements [

	| positions |
	self ids: (self createIdMapping: elements).
		
	self removeTemporaryFiles.

	self createDotFileNodes: elements connections: edgeElements.
	
	self callGraphViz isNil ifTrue: [^ self].

	positions := self readLayoutFile.
	
	self applyLayoutToNodes: elements with: positions
]

{ #category : #layout }
RTGraphVizLayout >> readLayoutFile [

	| dot positions element controlPoints point separator |

	dot := FileStream fileNamed: 'mondrian_plain'.
	positions := Dictionary new.
	OSProcess isWindows
		ifTrue: [ separator := String crlf ]
		ifFalse: [ separator := String lf ].
	
	
	"graph header"
	element := (dot upToAll: separator ) subStrings: ' '.
	self extent: ((element at: 3) asNumber @ (element at: 4) asNumber) * self scaleFactor.
	
	"each line"
	element := (dot upToAll: separator) subStrings: ' '.
	
	[ (element at: 1) ~= 'stop' and: [ (element at: 1) ~= '' ] ]
		whileTrue: [
			"if node, save its position"
			(element first) = 'node' ifTrue: [
				positions at: (element at: 2) asNumber
						 put: (((element at: 3) asNumber) @ ((element at: 4) asNumber) * self scaleFactor)
			].

			"if edge, save all its control points"
			element first = 'edge' ifTrue: [
				controlPoints := OrderedCollection new.
				0 to: ((element at: 4) asNumber - 1) do: [ :index |
					point := ((element at: 5 + (index*2)) asNumber @ (element at: 6 + (index*2)) asNumber).
					controlPoints add: point * self scaleFactor .
				].
			
				positions at: ((element at: 2) asNumber -> (element at: 3) asNumber)
						 put: controlPoints.
			].
			
			element := (dot upToAll: separator) subStrings: ' '.
		].

	^ positions
]

{ #category : #layout }
RTGraphVizLayout >> removeTemporaryFiles [
	(Smalltalk imageDirectory / 'mondrian_dot') ensureDeleted .
	(Smalltalk imageDirectory / 'mondrian_plain') ensureDeleted.
]

{ #category : #accessing }
RTGraphVizLayout >> root [	
	^ root
]

{ #category : #accessing }
RTGraphVizLayout >> root: anObject [
	"This specifies nodes to be used as the center of the layout and the root of the generated spanning tree. As a graph attribute, this gives the name of the node. As a node attribute (circo only), it specifies that the node should be used as a central node. In twopi, this will actually be the central node. In circo, the block containing the node will be central in the drawing of its connected component. If not defined, twopi will pick a most central node, and circo will pick a random node."
	
	root := anObject
]

{ #category : #constants }
RTGraphVizLayout >> scaleFactor [
	^ 72.0
	
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> sfdp [
	"sfdp - multiscale version of fdp for the layout of large graphs."
	^ self layout: 'sfdp'
]

{ #category : #'accessing-convenience' }
RTGraphVizLayout >> twopi [
	"twopi - radial layouts, after Graham Wills 97. The nodes are placed on concentric circles depending their distance from a given root node."
	^ self layout: 'twopi'
]

{ #category : #accessing }
RTGraphVizLayout >> useSplines [
	^ useSplines
]

{ #category : #accessing }
RTGraphVizLayout >> useSplines: anObject [
	useSplines := anObject
]
