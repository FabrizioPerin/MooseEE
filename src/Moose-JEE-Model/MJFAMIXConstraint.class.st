Class {
	#name : #MJFAMIXConstraint,
	#superclass : #FAMIXEntity,
	#instVars : [
		'name',
		'isPKConstraint',
		'isFKConstraint',
		'fkReferencedTableName',
		'fkColumns',
		'pkColumns'
	],
	#category : #'Moose-JEE-Model'
}
