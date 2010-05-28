Class {
	#name : #JEETestModels,
	#superclass : #Object,
	#category : #'Moose-JEE-Tests'
}

{ #category : #classes }
JEETestModels >> class1 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class1;
			yourself.

	method1 := FAMIXMethod new
				name: #method11;
				parentType: class;
				signature: 'method11()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method12;
				parentType: class;
				signature: 'method12()';
				yourself.

	method3 := FAMIXMethod new
				name: #method13;
				parentType: class;
				signature: 'method13()';
				yourself.

	method4 := FAMIXMethod new
				name: #method14;
				parentType: class;
				signature: 'method14()';
				yourself.

	method5 := FAMIXMethod new
				name: #method15;
				parentType: class;
				signature: 'method15()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class2 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class2;
			yourself.

	method1 := FAMIXMethod new
				name: #method21;
				parentType: class;
				signature: 'method21()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method22;
				parentType: class;
				signature: 'method22()';
				yourself.

	method3 := FAMIXMethod new
				name: #method23;
				parentType: class;
				signature: 'method23()';
				yourself.

	method4 := FAMIXMethod new
				name: #method24;
				parentType: class;
				signature: 'method24()';
				yourself.

	method5 := FAMIXMethod new
				name: #method25;
				parentType: class;
				signature: 'method25()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class3 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class3;
			yourself.

	method1 := FAMIXMethod new
				name: #method31;
				parentType: class;
				signature: 'method31()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method32;
				parentType: class;
				signature: 'method32()';
				yourself.

	method3 := FAMIXMethod new
				name: #method33;
				parentType: class;
				signature: 'method33()';
				yourself.

	method4 := FAMIXMethod new
				name: #method34;
				parentType: class;
				signature: 'method34()';
				yourself.

	method5 := FAMIXMethod new
				name: #method35;
				parentType: class;
				signature: 'method35()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class4 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class4;
			yourself.

	method1 := FAMIXMethod new
				name: #method41;
				parentType: class;
				signature: 'method41()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method42;
				parentType: class;
				signature: 'method42()';
				yourself.

	method3 := FAMIXMethod new
				name: #method43;
				parentType: class;
				signature: 'method43()';
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method44;
				parentType: class;
				signature: 'method44()';
				yourself.

	method5 := FAMIXMethod new
				name: #method45;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: 'method45()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class5 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class5;
			yourself.

	method1 := FAMIXMethod new
				name: #method51;
				parentType: class;
				signature: 'method51()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method52;
				parentType: class;
				signature: 'method52()';
				yourself.

	method3 := FAMIXMethod new
				name: #method53;
				parentType: class;
				signature: 'method53()';
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method54;
				parentType: class;
				signature: 'method54()';
				yourself.

	method5 := FAMIXMethod new
				name: #method55;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: 'method55()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class6 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class6;
			yourself.

	method1 := FAMIXMethod new
				name: #method61;
				parentType: class;
				signature: 'method61()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method62;
				parentType: class;
				signature: 'method62()';
				yourself.

	method3 := FAMIXMethod new
				name: #method63;
				parentType: class;
				signature: 'method63()';
				yourself.

	method4 := FAMIXMethod new
				name: #method64;
				parentType: class;
				signature: 'method64()';
				yourself.

	method5 := FAMIXMethod new
				name: #method65;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: 'method65()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class7 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class7;
			yourself.

	method1 := FAMIXMethod new
				name: #method71;
				parentType: class;
				signature: #method71;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method72;
				parentType: class;
				signature: #method72;
				yourself.

	method3 := FAMIXMethod new
				name: #method73;
				parentType: class;
				signature: #method73;
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method74;
				parentType: class;
				signature: #method74;
				yourself.

	method5 := FAMIXMethod new
				name: #method75;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: #method75;
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class8 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class8;
			yourself.

	method1 := FAMIXMethod new
				name: #method81;
				parentType: class;
				signature: #method81;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method82;
				parentType: class;
				signature: #method82;
				yourself.

	method3 := FAMIXMethod new
				name: #method83;
				parentType: class;
				signature: #method83;
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method84;
				parentType: class;
				signature: #method84;
				yourself.

	method5 := FAMIXMethod new
				name: #method85;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: #method85;
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> class9 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #Class9;
			yourself.

	method1 := FAMIXMethod new
				name: #method91;
				parentType: class;
				signature: #method91;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method92;
				parentType: class;
				signature: #method92;
				yourself.

	method3 := FAMIXMethod new
				name: #method93;
				parentType: class;
				signature: #method93;
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method94;
				parentType: class;
				signature: #method94;
				yourself.

	method5 := FAMIXMethod new
				name: #method95;
				parentType: class;
				ejbTransactionType: 'Required';
				signature: #method95;
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> dto1 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #ClassDTO1;
			yourself.

	method1 := FAMIXMethod new
				name: #methodDTO11;
				parentType: class;
				signature: #methodDTO11;
				yourself.
	
	method2 := FAMIXMethod new
				name: #methodDTO12;
				parentType: class;
				signature: #methodDTO12;
				yourself.

	method3 := FAMIXMethod new
				name: #methodDTO13;
				parentType: class;
				signature: #methodDTO13;
				yourself.

	method4 := FAMIXMethod new
				name: #methodDTO14;
				parentType: class;
				signature: #methodDTO14;
				yourself.

	method5 := FAMIXMethod new
				name: #methodDTO15;
				parentType: class;
				signature: #methodDTO15;
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> dto2 [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #ClassDTO2;
			yourself.

	method1 := FAMIXMethod new
				name: #methodDTO21;
				parentType: class;
				signature: #methodDTO21;
				yourself.
	
	method2 := FAMIXMethod new
				name: #methodDTO22;
				parentType: class;
				signature: #methodDTO22;
				yourself.

	method3 := FAMIXMethod new
				name: #methodDTO23;
				parentType: class;
				signature: #methodDTO23;
				yourself.

	method4 := FAMIXMethod new
				name: #methodDTO24;
				parentType: class;
				signature: #methodDTO24;
				yourself.

	method5 := FAMIXMethod new
				name: #methodDTO25;
				parentType: class;
				signature: #methodDTO25;
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> dto3 [
	"This DTOs should match because extends serilizable"
	
	| class serializableClass method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #DataTranferObject3;
			yourself.

	method1 := FAMIXMethod new
				name: #methodDTO31;
				parentType: class;
				signature: 'methodDTO31()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #methodDTO32;
				parentType: class;
				signature: 'methodDTO32()';
				yourself.

	method3 := FAMIXMethod new
				name: #methodDTO33;
				parentType: class;
				signature: 'methodDTO33()';
				yourself.

	method4 := FAMIXMethod new
				name: #methodDTO34;
				parentType: class;
				signature: 'methodDTO34()';
				yourself.

	method5 := FAMIXMethod new
				name: #methodDTO35;
				parentType: class;
				signature: 'methodDTO35()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #models }
JEETestModels >> mooseModelWithDTOs [

	| mooseModel aPackage class1 class2 class3 class4 dto1 anotherPackage class5 class6 class7 class8 class9 aDtosPackage dto2 inheritance sender receiver invocation aStatelessSessionBean aMethod aStatefulSessionBean someMethod someOtherMethod prepareStatement serializableClass dto3 |

	mooseModel := MooseModel new name: #mooseModelWithDTOs.

	"aPackage definition"
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.

	class1 := self class1.
	class1 container: aPackage.
	
	class2 := self class2.
	class2 container: aPackage.
	
	class3 := self class3.
	class3 container: aPackage.

	class4 := self class4.
	class4 container: aPackage.

	dto1 := self dto1.
	dto1 container: aPackage.
	
	"Inheritance in package aPackage"
	inheritance := FAMIXInheritance new 
					superclass: class1; 
					subclass: class2.
	mooseModel add: inheritance.

	class2 addSuperInheritance: inheritance.
	class1 addSubInheritance: inheritance.
	
	inheritance := FAMIXInheritance new 
					superclass: class2; 
					subclass: class3.
	mooseModel add: inheritance.

	class3 addSuperInheritance: inheritance.
	class2 addSubInheritance: inheritance.

	"anotherPackage definition"
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.
			
	class5 := self class5.
	class5 container: anotherPackage.
	
	class6 := self class6.
	class6 container: anotherPackage.
	
	class7 := self class7.
	class7 container: anotherPackage.
	
	class8 := self class8.
	class8 container: anotherPackage.
	
	class9 := self class9.
	class9 container: anotherPackage.
	
	"inheritance in anotherPackage"	
	inheritance := FAMIXInheritance new 
					superclass: class6; 
					subclass: class7.
	mooseModel add: inheritance.
	
	class7 addSuperInheritance: inheritance.
	class6 addSubInheritance: inheritance.
	
	
	"DTOs package"
	aDtosPackage := FAMIXNamespace new
			name: #aDtosPackage;
			yourself.
	
	dto2 := self dto2.
	dto2 container: aDtosPackage.

	"Serializable dto"
	serializableClass := FAMIXClass new
			name: #Serializable;
			isInterface: true;
			yourself.

	dto3 := self dto3.
	dto3 container: aDtosPackage.

	inheritance := FAMIXInheritance new 
					superclass: serializableClass; 
					subclass: dto3.
	mooseModel add: inheritance.

	dto3 addSuperInheritance: inheritance.
	serializableClass addSubInheritance: inheritance.



	"other invocation"
	sender := (class2 methods select: [:m | m name = #method22]) first.
	receiver := (class2 methods select: [:m | m name = #method24]) first.
	receiver declaredType: dto3.
	invocation := FAMIXInvocation new sender: sender; addCandidate: receiver; signature: receiver signature; yourself.
	sender addOutgoingInvocation: invocation.
	receiver addIncomingInvocation: invocation.
	mooseModel add: invocation.

	sender := (class2 methods select: [:m | m name = #method24]) first.
	receiver := (class5 methods select: [:m | m name = #method54]) first.
	receiver declaredType: dto3.
	invocation := FAMIXInvocation new sender: sender; addCandidate: receiver; signature: receiver signature; yourself.
	sender addOutgoingInvocation: invocation.
	receiver addIncomingInvocation: invocation.
	mooseModel add: invocation.

	sender := (class5 methods select: [:m | m name = #method54]) first.
	receiver := (class9 methods select: [:m | m name = #method93]) first.
	receiver declaredType: dto3.
	invocation := FAMIXInvocation new sender: sender; addCandidate: receiver; signature: receiver signature; yourself.
	sender addOutgoingInvocation: invocation.
	receiver addIncomingInvocation: invocation.
	mooseModel add: invocation.

	sender := (class9 methods select: [:m | m name = #method93]) first.
	receiver := (dto3 methods select: [:m | m name = #methodDTO31]) first.
	receiver declaredType: dto3.
	invocation := FAMIXInvocation new sender: sender; addCandidate: receiver; signature: receiver signature; yourself.
	sender addOutgoingInvocation: invocation.
	receiver addIncomingInvocation: invocation.
	mooseModel add: invocation.



"	java := FAMIXNamespace new
			name: #java;
			yourself.
			
	sql := FAMIXNamespace new
			name: #sql;
			parentScope: java;
			yourself.
			
	prepareStatement := FAMIXClass new
						name: #prepareStatment;
						container: sql;
						yourself.
	methodThatExecute := FAMIXMethod new
							name: #executeBatch;
							parentType: prepareStatement;
							signature: #executeBatch;
							yourself.

	prepareStatement addMethod: (methodThatExecute)."

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod;
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod;
				yourself.

	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod;
				yourself.	

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod).


	"invocation to method that executes a queryes"
"	invocation := FAMIXInvocation new sender: method1; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method1 addOutgoingInvocation: invocation.
	methodThatExecute addIncomingInvocation: invocation.

	invocation2 := FAMIXInvocation new sender: method2; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method2 addOutgoingInvocation: invocation2.
	methodThatExecute addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method3; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method3 addOutgoingInvocation: invocation3.
	methodThatExecute addIncomingInvocation: invocation3."

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class1 methods;
		addAll: class2 methods;
		addAll: class3 methods;
		addAll: class4 methods;
		addAll: class5 methods;
		addAll: class6 methods;
		addAll: class7 methods;
		addAll: class8 methods;
		addAll: class9 methods;
		addAll: dto1 methods;
		addAll: dto2 methods;
		addAll: dto3 methods;
		add: dto1;
		add: dto2;
		add: dto3;
		add: serializableClass;
		add: aPackage;
		add: anotherPackage;
		add: aDtosPackage;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatelessSession;
			container: aPackage;
			yourself
		);
		add: aStatelessSessionBean;
		add: (FAMIXClass new
			name: #AStatefulSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatefulSession;
			container: aPackage;
			yourself
		);
		add: aStatefulSessionBean;
		add: (FAMIXClass new
			name: #ACMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityPK;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AMessageBean;
			container: aPackage;
			yourself
		).

	^mooseModel
]

{ #category : #classes }
JEETestModels >> testClass [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #TestClass;
			yourself.

	method1 := FAMIXMethod new
				name: #methodTC1;
				parentType: class;
				signature: 'methodTC1()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #methodTC2;
				parentType: class;
				signature: 'methodTC2()';
				yourself.

	method3 := FAMIXMethod new
				name: #methodTC3;
				parentType: class;
				signature: 'methodTC3()';
				yourself.

	method4 := FAMIXMethod new
				name: #methodTC4;
				parentType: class;
				signature: 'methodTC4()';
				yourself.

	method5 := FAMIXMethod new
				name: #methodTC5;
				parentType: class;
				signature: 'methodTC5()';
				yourself.

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #classes }
JEETestModels >> testNamespace [

	| namespace |

	namespace := FAMIXNamespace new
			name: #aTestNamespace;
			yourself.

	^namespace 
]
