Extension { #name : #String }

{ #category : #'*Moose-JEE-Core-Model' }
String >> transformInMoosePathFormat [
	| res |
	
	res := self removePrefix: $/ asString.
	res := res removePrefix: $\ asString.
	res := res copyReplaceAll: $/ asString with: '::'.
	res := res copyReplaceAll: $\ asString with: '::'.
	^ res
	
	"'/home/saeed/code/org/compiere/model/MSequence.java' transformInMoosePathFormat 'home::saeed::code::org::compiere::model::MSequence.java'"
]

{ #category : #'*Moose-JEE-Core-Model' }
String >> withoutLineEndings [
	"assume the string is textual, and that CR, LF, and CRLF are all 
	valid line endings.  Replace each occurence with ''"
	| cr lf crlf|
	cr := String cr.	
	lf := String lf.
	crlf := String crlf.
	
	^((self copyReplaceAll: cr with: '') copyReplaceAll: lf with: '') copyReplaceAll: crlf with: ''
	
	" 'asdf
	asdfdd
	cemjvu' withoutLineEndings "
	
	

]
