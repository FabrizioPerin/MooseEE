Class {
	#name : #CCReportImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-Importer'
}

{ #category : #'as yet unclassified' }
CCReportImporterTests >> initialize [
	| parser factory doc |

	parser := XMLDOMParser on: self minimalEjbJar readStream.
	factory := XMLPluggableElementFactory new
				elementClass: MJEJBeanElement;
				handleElement: 'entity' withClass: MJEntityElement;
				handleElement: 'message-driven' withClass: MJMessageDrivenElement;
				handleElement: 'session' withClass: MJSessionElement;
				handleElement: 'container-transaction' withClass: MJContainerTransactionElement.

	parser nodeFactory: factory.  

	doc := parser parseDocument.
	root := doc root.
]
