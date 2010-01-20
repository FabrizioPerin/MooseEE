Extension { #name : #String }

{ #category : #'*Moose-JEE' }
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
