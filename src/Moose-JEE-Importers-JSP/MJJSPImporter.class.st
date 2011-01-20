Class {
	#name : #MJJSPImporter,
	#superclass : #Object,
	#category : #'Moose-JEE-Importers-JSP'
}

{ #category : #'as yet unclassified' }
MJJSPImporter >> populate: aMooseModel withJSPsFrom: aBlackBoard [

	| jsPage draftJSPage |
	
	
	draftJSPage := aBlackBoard jsPages last.
	
	jsPage := MJFAMIXJSPPage new.
	
	jsPage name: draftJSPage name.
	jsPage filedIn: draftJSPage filedIn.
	
	aMooseModel add: jsPage.
	
	draftJSPage containedTags do: [:each | 
		
			(each name = 'useBean') 
				ifTrue: [
					| att class jspInvocation |
					
					att := (each attributes select: [:attr | attr name = 'class']) first.
					
					class := aMooseModel entityNamed: (att value copyReplaceAll: '.' with: '::').
					self halt.
					jspInvocation := MJFAMIXJSPInvocation new invocationSource: jsPage; invocationTarget: class.
					
					class addIncomingJspInvocation: jspInvocation.
					jsPage addOutgoingJspInvocations: jspInvocation.
					
					aMooseModel withoutAnnounceAdd: jspInvocation.
					]
	].

	^aMooseModel
]
