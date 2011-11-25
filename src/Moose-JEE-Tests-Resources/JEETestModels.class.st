Class {
	#name : #JEETestModels,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-Tests-Resources'
}

{ #category : #elements }
JEETestModels >> aTableThatReferencesItselfsThroughAForeignKey [

^'CREATE TABLE A_Asset(
    A_Asset_ID                   NUMBER(10, 0)      NOT NULL,
    AD_Client_ID                 NUMBER(10, 0)      NOT NULL,
    AD_Org_ID                    NUMBER(10, 0)      NOT NULL,
    Created                      DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                    NUMBER(10, 0)      NOT NULL,
    Updated                      DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                    NUMBER(10, 0)      NOT NULL,
    Value                        NVARCHAR2(40)      NOT NULL,
    Name                         NVARCHAR2(60)      NOT NULL,
    Description                  NVARCHAR2(255),
    Help                         NVARCHAR2(2000),
    A_Asset_Group_ID             NUMBER(10, 0)      NOT NULL,
    Parent_Asset_ID              NUMBER(10, 0),
    M_Product_ID                 NUMBER(10, 0),
    M_AttributeSetInstance_ID    NUMBER(10, 0),
    C_UOM_ID                     NUMBER(10, 0),
    SerNo                        NVARCHAR2(40),
    Lot                          NVARCHAR2(40),
    VersionNo                    NVARCHAR2(40),
    GuaranteeDate                DATE               NOT NULL,
    AssetServiceDate             DATE               NOT NULL,
    AssetDisposalDate            DATE               NOT NULL,
    LocationComment              NVARCHAR2(255),
    M_Locator_ID                 NUMBER(10, 0),
    C_BPartner_ID                NUMBER(10, 0),
    C_BPartner_Location_ID       NUMBER(10, 0),
    AD_User_ID                   NUMBER(10, 0),
    C_Location_ID                NUMBER(10, 0),
    LastMaintenanceDate          DATE               NOT NULL,
    NextMaintenanceDate          DATE               NOT NULL,
    LastMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    NextMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    Lease_BPartner_ID            NUMBER(10, 0),
    LeaseTerminationDate         DATE               NOT NULL,
    Processing                   CHAR(1),
    CONSTRAINT A_Asset_Key PRIMARY KEY (A_Asset_ID)
);


ALTER TABLE A_Asset ADD CONSTRAINT AAsset_Parent 
    FOREIGN KEY (Parent_Asset_ID)
    REFERENCES A_Asset(A_Asset_ID);'

]

{ #category : #elements }
JEETestModels >> attributeCalled: aString belongsTo: aType withClassScope: aBoolean [
	|attribute|

	attribute := FAMIXAttribute new
		name: aString;
		parentType: aType;
		declaredType: aBoolean;
		yourself.
	
	^attribute
]

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
JEETestModels >> classWithComplexMethods [

	| class method1 method2 method3 method4 method5 |
	
	class := FAMIXClass new
			name: #ClassWithComplexMethod;
			yourself.

	method1 := FAMIXMethod new
				name: #method11;
				parentType: class;
				declaredType: class;
				signature: 'method11()';
				yourself.
	
	method2 := FAMIXMethod new
				name: #method12;
				parentType: class;
				declaredType: (FAMIXClass new name: #String);
				signature: 'method12()';
				yourself.

	self parameterCalled: 'par1' belongsTo: method2 with: class. 
	self parameterCalled: 'par2' belongsTo: method2 with: (FAMIXClass new name: #String).
	self parameterCalled: 'par3' belongsTo: method2 with: (FAMIXClass new name: #BoolClass).
	
	method3 := FAMIXMethod new
				name: #method13;
				parentType: class;
				signature: 'method13()';
				yourself.
	
	self parameterCalled: 'par1' belongsTo: method3 with: (FAMIXClass new name: #String).
	self parameterCalled: 'par4' belongsTo: method3 with: (FAMIXClass new name: #BoolClass).

	method4 := FAMIXMethod new
				name: #method14;
				parentType: class;
				signature: 'method14()';
				yourself.
	
	self localVariableCalled: 'var1' belongsTo: method4 with: class.
	self localVariableCalled: 'var2' belongsTo: method4 with: (FAMIXClass new name: #String).
	self localVariableCalled: 'var3' belongsTo: method4 with: (FAMIXClass new name: #BoolClass).

	method5 := FAMIXMethod new
				name: #method15;
				parentType: class;
				signature: 'method15()';
				yourself.

	self localVariableCalled: 'var1' belongsTo: method5 with: (FAMIXClass new name: #String).
	self localVariableCalled: 'var2' belongsTo: method5 with: (FAMIXClass new name: #BoolClass).
		

	class	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5).
	
	^class
]

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #elements }
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

{ #category : #files }
JEETestModels >> fakeSourceText [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "Table1", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "Column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "Column5")
  private String allOperations;

  @Column(name = "Column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #files }
JEETestModels >> fakeSourceTextWithLowerCaseNames [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "table1", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "column5")
  private String allOperations;

  @Column(name = "column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #files }
JEETestModels >> fakeSourceTextWithTable2 [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "Table2", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "Column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "Column5")
  private String allOperations;

  @Column(name = "Column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #elements }
JEETestModels >> fiveTablesConnectedThroughForeignKey [

^'CREATE TABLE Tab1(
    tab1_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab1_col1 NUMBER(10, 0) ,
   tab1_col2                   NUMBER(10, 0),
    tab1_col3                      DATE ,
    tab1_col4                    NVARCHAR2(255)      NOT NULL,
     tab1_col5                      CHAR(1) DEFAULT N);

CREATE TABLE Tab2(
    tab2_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab2_col1 NUMBER(10, 0)      NOT NULL,
   tab2_col2                   NUMBER(10, 0)      NOT NULL ,
    tab2_col3                      DATE                NOT NULL,
    tab2_col4                    NVARCHAR2(255)      NOT NULL,
     tab2_col5                      CHAR(1) DEFAULT N);

CREATE TABLE Tab3(
    tab3_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab3_col1 NUMBER(10, 0)      NOT NULL ,
   tab3_col2                   NUMBER(10, 0)    NOT NULL ,
    tab3_col3                      DATE           NOT NULL,
    tab3_col4                    NVARCHAR2(255)      NOT NULL,
     tab3_col5                      CHAR(1) DEFAULT N,
	tab3_tab1_FK NUMBER(10),
	tab3_tab2_FK NUMBER(10));

CREATE TABLE Tab4(
    tab4_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab4_col1 NUMBER(10, 0)      NOT NULL ,
   tab4_col2                   NUMBER(10, 0)      NOT NULL ,
    tab4_col3                      DATE                NOT NULL,
    tab4_col4                    NVARCHAR2(255)      NOT NULL,
     tab4_col5                      CHAR(1) DEFAULT N,
	tab4_tab3_FK NUMBER(10,0));

CREATE TABLE Tab5(
    tab5_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab5_col1 NUMBER(10, 0)      NOT NULL ,
   tab5_col2                   NUMBER(10, 0)      NOT NULL ,
    tab5_col3                      DATE                NOT NULL,
    tab5_col4                    NVARCHAR2(255)     NOT NULL,
     tab5_col5                      CHAR(1) DEFAULT N,
	tab5_tab3_FK NUMBER(10,0));


ALTER TABLE Tab3 ADD CONSTRAINT tab1_to_tab3
    FOREIGN KEY (tab3_tab1_FK)
    REFERENCES Tab1(tab1_ID);

ALTER TABLE Tab3 ADD CONSTRAINT tab2_to_tab3
    FOREIGN KEY (tab3_tab2_FK)
    REFERENCES Tab2(tab2_ID);

ALTER TABLE Tab4 ADD CONSTRAINT tab3_to_tab4
    FOREIGN KEY (tab4_tab3_FK)
    REFERENCES Tab3(tab3_ID);

ALTER TABLE Tab5 ADD CONSTRAINT tab3_to_tab5
    FOREIGN KEY (tab5_tab3_FK)
    REFERENCES Tab3(tab3_ID)'

]

{ #category : #initialize }
JEETestModels >> initialize [
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

{ #category : #elements }
JEETestModels >> localVariableCalled: aString belongsTo: aBehaviouralEntity with: aDeclaredType [
	|localVariable|

	localVariable := FAMIXLocalVariable new
		name: aString;
		parentBehaviouralEntity: aBehaviouralEntity;
		declaredType: aDeclaredType;
		yourself.
	
	^localVariable
]

{ #category : #files }
JEETestModels >> minimalEjbJar [

	^'<?xml version="1.0"?>
<ejb-jar>

<enterprise-beans>

	<!-- A minimal session EJB deployment -->
	<session>
 		 <ejb-name>AStatefulSession</ejb-name>
		<home>aPackage.AStatefulSessionHome</home>
		<remote>aPackage.AStatefulSession</remote>
		<ejb-class>aPackage.AStatefulSessionBean</ejb-class>
		<session-type>Stateful</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<session>
 		 <ejb-name>AStatelessSession</ejb-name>
		<home>aPackage.AStatelessSessionHome</home>
		<remote>aPackage.AStatelessSession</remote>
		<ejb-class>aPackage.AStatelessSessionBean</ejb-class>
		<session-type>Stateless</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<!-- A minimal CMP entity EJB deployment -->
	<entity>
		<ejb-name>ACMPEntity</ejb-name>
		<home>anotherPackage.ACMPEntityHome</home>
		<remote>anotherPackage.ACMPEntity</remote>
		<ejb-class>anotherPackage.ACMPEntityBean</ejb-class>
		<persistence-type>Container</persistence-type>
		<prim-key-class>anotherPackage.ACMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
		<cmp-field><field-name>attribute1</field-name></cmp-field>
		<cmp-field><field-name>attribute2</field-name></cmp-field>
      </entity>
      
	<!-- A minimal BMP entity EJB deployment -->
	<entity>
		<ejb-name>ABMPEntity</ejb-name>
		<home>anotherPackage.ABMPEntityHome</home>
		<remote>anotherPackage.ABMPEntity</remote>
		<ejb-class>anotherPackage.ABMPEntityBean</ejb-class>
		<persistence-type>Bean</persistence-type>
		<prim-key-class>anotherPackage.ABMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
	</entity>

	<message-driven>
		<ejb-name>AMessageDriven</ejb-name>
		<ejb-class>aPackage.AMessageBean</ejb-class>
		<transaction-type>Container</transaction-type>
		<message-driven-destination>
			<destination-type>
				javax.jms.Topic
			</destination-type>
		</message-driven-destination>
		...
	</message-driven>

</enterprise-beans>

<assembly-descriptor>

	<container-transaction> 
		<method> 
			<ejb-name>AStatefulSession</ejb-name> 
			<method-name>*</method-name> 
		</method> 
		<trans-attribute>Required</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>AStatelessSession</ejb-name> 
			<method-name>aMethod</method-name> 
		</method> 
		<trans-attribute>Mandatory</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>ABMPEntity</ejb-name> 
			<method-name>a*</method-name> 
		</method> 
		<trans-attribute>RequiresNew</trans-attribute> 
	</container-transaction> 

</assembly-descriptor>

</ejb-jar>
'
]

{ #category : #files }
JEETestModels >> minimalEjbJarWithSupportedTransactions [

	^'<?xml version="1.0"?>
<ejb-jar>

<enterprise-beans>

	<!-- A minimal session EJB deployment -->
	<session>
 		 <ejb-name>AStatefulSession</ejb-name>
		<home>aPackage.AStatefulSessionHome</home>
		<remote>aPackage.AStatefulSession</remote>
		<ejb-class>aPackage.AStatefulSessionBean</ejb-class>
		<session-type>Stateful</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<session>
 		 <ejb-name>AStatelessSession</ejb-name>
		<home>aPackage.AStatelessSessionHome</home>
		<remote>aPackage.AStatelessSession</remote>
		<ejb-class>aPackage.AStatelessSessionBean</ejb-class>
		<session-type>Stateless</session-type>
		<transaction-type>Container</transaction-type>
	</session>

	<!-- A minimal CMP entity EJB deployment -->
	<entity>
		<ejb-name>ACMPEntity</ejb-name>
		<home>anotherPackage.ACMPEntityHome</home>
		<remote>anotherPackage.ACMPEntity</remote>
		<ejb-class>anotherPackage.ACMPEntityBean</ejb-class>
		<persistence-type>Container</persistence-type>
		<prim-key-class>anotherPackage.ACMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
		<cmp-field><field-name>attribute1</field-name></cmp-field>
		<cmp-field><field-name>attribute2</field-name></cmp-field>
      </entity>
      
	<!-- A minimal BMP entity EJB deployment -->
	<entity>
		<ejb-name>ABMPEntity</ejb-name>
		<home>anotherPackage.ABMPEntityHome</home>
		<remote>anotherPackage.ABMPEntity</remote>
		<ejb-class>anotherPackage.ABMPEntityBean</ejb-class>
		<persistence-type>Bean</persistence-type>
		<prim-key-class>anotherPackage.ABMPEntityPK</prim-key-class>
		<reentrant>False</reentrant>
	</entity>

	<message-driven>
		<ejb-name>AMessageDriven</ejb-name>
		<ejb-class>aPackage.AMessageBean</ejb-class>
		<transaction-type>Container</transaction-type>
		<message-driven-destination>
			<destination-type>
				javax.jms.Topic
			</destination-type>
		</message-driven-destination>
		...
	</message-driven>

</enterprise-beans>

<assembly-descriptor>

	<container-transaction> 
		<method> 
			<ejb-name>AStatefulSession</ejb-name> 
			<method-name>*</method-name> 
		</method> 
		<trans-attribute>Support</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>AStatelessSession</ejb-name> 
			<method-name>aMethod</method-name> 
		</method> 
		<trans-attribute>NotSupport</trans-attribute> 
	</container-transaction> 
	<container-transaction> 
		<method> 
			<ejb-name>ABMPEntity</ejb-name> 
			<method-name>*</method-name> 
		</method> 
		<trans-attribute>requires</trans-attribute> 
	</container-transaction> 

</assembly-descriptor>

</ejb-jar>
'
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


	"invocation chain returning always the same type of DTO"
	sender := (class2 methods select: [:m | m name = #method23]) first.
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
	receiver := (class9 methods select: [:m | m name = #method94]) first.
	receiver declaredType: dto3.
	invocation := FAMIXInvocation new sender: sender; addCandidate: receiver; signature: receiver signature; yourself.
	sender addOutgoingInvocation: invocation.
	receiver addIncomingInvocation: invocation.
	mooseModel add: invocation.

	sender := (class9 methods select: [:m | m name = #method94]) first.
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

	aStatelessSessionBean 
			addMethod: (aMethod);
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

{ #category : #files }
JEETestModels >> normalEjbJar [

	^'<?xml version="1.0" encoding="UTF-8"?>

<ejb-jar id="ejb-jar_1" xmlns="http://java.sun.com/xml/ns/j2ee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/ejb-jar_2_1.xsd" version="2.1">

   <description><![CDATA[No Description.]]></description>
   <display-name>Generated by XDoclet</display-name>

   <enterprise-beans>

      <!-- Session Beans -->
      <session id="Session_JIPPSProperties">
         <description><![CDATA[An EJB named JIPPSProperties]]></description>
         <display-name>JIPPSProperties</display-name>

         <ejb-name>JIPPSProperties</ejb-name>

         <home>ch.ige.jipps.JIPPSPropertiesHome</home>
         <remote>ch.ige.jipps.JIPPSProperties</remote>
         <local-home>ch.ige.jipps.JIPPSPropertiesLocalHome</local-home>
         <local>ch.ige.jipps.JIPPSPropertiesLocal</local>
         <ejb-class>ch.ige.jipps.JIPPSPropertiesBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

         <resource-ref id="ResRef_1">
            <res-ref-name>mail/JavaMailSession</res-ref-name>
            <res-type>javax.mail.Session</res-type>
            <res-auth>Container</res-auth>
         </resource-ref>

      </session>

      <session id="Session_JIPPSInfo">
         <description><![CDATA[An EJB named JIPPSInfo]]></description>
         <display-name>JIPPSInfo</display-name>

         <ejb-name>JIPPSInfo</ejb-name>

         <home>ch.ige.jipps.JIPPSInfoHome</home>
         <remote>ch.ige.jipps.JIPPSInfo</remote>
         <local-home>ch.ige.jipps.JIPPSInfoLocalHome</local-home>
         <local>ch.ige.jipps.JIPPSInfoLocal</local>
         <ejb-class>ch.ige.jipps.JIPPSInfoBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

      </session>

      <session id="Session_JMSPublisher">
         <description><![CDATA[An EJB named JMSPublisher]]></description>
         <display-name>JMSPublisher</display-name>

         <ejb-name>JMSPublisher</ejb-name>

         <home>ch.ige.jipps.JMSPublisherHome</home>
         <remote>ch.ige.jipps.JMSPublisher</remote>
         <local-home>ch.ige.jipps.JMSPublisherLocalHome</local-home>
         <local>ch.ige.jipps.JMSPublisherLocal</local>
         <ejb-class>ch.ige.jipps.JMSPublisherBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

         <resource-ref id="ResRef_2">
            <res-ref-name>jms/PrintjobQueue</res-ref-name>
            <res-type>javax.jms.Destination</res-type>
            <res-auth>Container</res-auth>
         </resource-ref>
         <resource-ref id="ResRef_3">
            <res-ref-name>jms/PrintjobTopic</res-ref-name>
            <res-type>javax.jms.Destination</res-type>
            <res-auth>Container</res-auth>
         </resource-ref>
         <resource-ref id="ResRef_4">
            <res-ref-name>jms/ConnectionFactory</res-ref-name>
            <res-type>javax.jms.ConnectionFactory</res-type>
            <res-auth>Container</res-auth>
         </resource-ref>

      </session>

      <session id="Session_PrintJobStore">
         <description><![CDATA[An EJB named PrintJobStore]]></description>
         <display-name>PrintJobStore</display-name>

         <ejb-name>PrintJobStore</ejb-name>

         <local-home>ch.ige.jipps.PrintJobStoreLocalHome</local-home>
         <local>ch.ige.jipps.PrintJobStoreLocal</local>
         <ejb-class>ch.ige.jipps.PrintJobStoreBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

      </session>

      <session id="Session_JIPPSFacade">
         <description><![CDATA[JIPPS Facade]]></description>
         <display-name>JIPPSFacade</display-name>

         <ejb-name>JIPPSFacade</ejb-name>

         <home>ch.ige.jipps.JIPPSFacadeHome</home>
         <remote>ch.ige.jipps.JIPPSFacade</remote>
         <ejb-class>ch.ige.jipps.JIPPSFacadeBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

         <ejb-local-ref id="EJBLocalRef_1">
            <ejb-ref-name>ejb/JIPPSInfoLocal</ejb-ref-name>
            <ejb-ref-type>Session</ejb-ref-type>
            <local-home>ch.ige.jipps.JIPPSInfoLocalHome</local-home>
            <local>ch.ige.jipps.JIPPSInfoLocal</local>
            <ejb-link>JIPPSInfo</ejb-link>
         </ejb-local-ref>
         <ejb-local-ref id="EJBLocalRef_2">
            <ejb-ref-name>ejb/JMSPublisherLocal</ejb-ref-name>
            <ejb-ref-type>Session</ejb-ref-type>
            <local-home>ch.ige.jipps.JMSPublisherLocalHome</local-home>
            <local>ch.ige.jipps.JMSPublisherLocal</local>
            <ejb-link>JMSPublisher</ejb-link>
         </ejb-local-ref>
         <ejb-local-ref id="EJBLocalRef_3">
            <ejb-ref-name>ejb/PrintJobStoreLocal</ejb-ref-name>
            <ejb-ref-type>Session</ejb-ref-type>
            <local-home>ch.ige.jipps.PrintJobStoreLocalHome</local-home>
            <local>ch.ige.jipps.PrintJobStoreLocal</local>
            <ejb-link>PrintJobStore</ejb-link>
         </ejb-local-ref>
         <ejb-local-ref id="EJBLocalRef_4">
            <ejb-ref-name>ejb/JIPPSPropertiesLocal</ejb-ref-name>
            <ejb-ref-type>Session</ejb-ref-type>
            <local-home>ch.ige.jipps.JIPPSPropertiesLocalHome</local-home>
            <local>ch.ige.jipps.JIPPSPropertiesLocal</local>
            <ejb-link>JIPPSProperties</ejb-link>
         </ejb-local-ref>

         <resource-ref id="ResRef_5">
            <res-ref-name>mail/JavaMailSession</res-ref-name>
            <res-type>javax.mail.Session</res-type>
            <res-auth>Container</res-auth>
         </resource-ref>

      </session>

      <session id="Session_AmvTransactionManager">
         <description><![CDATA[AMVTransactionManager]]></description>
         <display-name>AmvTransactionManager</display-name>

         <ejb-name>AmvTransactionManager</ejb-name>

         <home>ch.ige.jipps.AmvTransactionManagerHome</home>
         <remote>ch.ige.jipps.AmvTransactionManager</remote>
         <ejb-class>ch.ige.jipps.AmvTransactionManagerBean</ejb-class>
         <session-type>Stateless</session-type>
         <transaction-type>Container</transaction-type>

      </session>

     <!--
       To add session beans that you have deployment descriptor info for, add
       a file to your XDoclet merge directory called session-beans.xml that contains
       the <session></session> markup for those beans.
     -->

      <!-- Entity Beans -->
     <!--
       To add entity beans that you have deployment descriptor info for, add
       a file to your XDoclet merge directory called entity-beans.xml that contains
       the <entity></entity> markup for those beans.
     -->

      <!-- Message Driven Beans -->
      <message-driven id="MessageDriven_1">
         <description><![CDATA[Reads from the JMS queue for publication confirmation letters coming from the Swissreg update.]]></description>

         <ejb-name>PublicationConfirmationMDBean</ejb-name>

         <ejb-class>ch.ige.jipps.PublicationConfirmationMDBean</ejb-class>

         <messaging-type>javax.jms.MessageListener</messaging-type>
         <transaction-type>Container</transaction-type>
         <message-destination-type>javax.jms.Queue</message-destination-type>
         <activation-config>
           <activation-config-property>
             <activation-config-property-name>destinationType</activation-config-property-name>
             <activation-config-property-value>javax.jms.Queue</activation-config-property-value>
           </activation-config-property>
         </activation-config>

      </message-driven>

      <message-driven id="MessageDriven_2">
         <description><![CDATA[DirectMDBean: Direkter Einstieg in die Komponente JIPPS.]]></description>

         <ejb-name>DirectMDBean</ejb-name>

         <ejb-class>ch.ige.jipps.DirectMDBean</ejb-class>

         <messaging-type>javax.jms.MessageListener</messaging-type>
         <transaction-type>Container</transaction-type>
         <message-destination-type>javax.jms.Queue</message-destination-type>
         <activation-config>
           <activation-config-property>
             <activation-config-property-name>destinationType</activation-config-property-name>
             <activation-config-property-value>javax.jms.Queue</activation-config-property-value>
           </activation-config-property>
         </activation-config>

      </message-driven>

     <!--
       To add message driven beans that you have deployment descriptor info for, add
       a file to your XDoclet merge directory called message-driven-beans.xml that contains
       the <message-driven></message-driven> markup for those beans.
     -->

   </enterprise-beans>

   <!-- Relationships -->

   <!-- Assembly Descriptor -->
     <!--
       To specify your own assembly descriptor info here, add a file to your
       XDoclet merge directory called assembly-descriptor.xml that contains
       the <assembly-descriptor></assembly-descriptor> markup.
     -->

   <assembly-descriptor id="AssemblyDescriptor_1">
     <!--
       To specify additional security-role elements, add a file in the merge
       directory called ejb-security-roles.xml that contains them.
     -->

   <!-- method permissions -->
     <!--
       To specify additional method-permission elements, add a file in the merge
       directory called ejb-method-permissions.ent that contains them.
     -->

   <!-- transactions -->
     <!--
       To specify additional container-transaction elements, add a file in the merge
       directory called ejb-container-transactions.ent that contains them.
     -->
   <container-transaction id="MethodTransaction_1">
      <method id="MethodElement_1">
         <ejb-name>JIPPSProperties</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>RequiresNew</trans-attribute>
    </container-transaction>
   <container-transaction id="MethodTransaction_2">
      <method id="MethodElement_2">
         <ejb-name>JIPPSInfo</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>RequiresNew</trans-attribute>
    </container-transaction>
   <container-transaction id="MethodTransaction_3">
      <method id="MethodElement_3">
         <ejb-name>JMSPublisher</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>Supports</trans-attribute>
    </container-transaction>
   <container-transaction id="MethodTransaction_4">
      <method id="MethodElement_4">
         <ejb-name>JMSPublisher</ejb-name>
         <method-intf>Local</method-intf>
         <method-name>getInstalledPrintersFromPrintservice</method-name>
         <method-params>
         </method-params>
      </method>
      <trans-attribute>NotSupported</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_5">
      <method id="MethodElement_5">
         <ejb-name>JMSPublisher</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>getInstalledPrintersFromPrintservice</method-name>
         <method-params>
         </method-params>
      </method>
      <trans-attribute>NotSupported</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_6">
      <method id="MethodElement_6">
         <ejb-name>PrintJobStore</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>RequiresNew</trans-attribute>
    </container-transaction>
   <container-transaction id="MethodTransaction_7">
      <method id="MethodElement_7">
         <ejb-name>JIPPSFacade</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>Required</trans-attribute>
    </container-transaction>
   <container-transaction id="MethodTransaction_8">
      <method id="MethodElement_8">
         <ejb-name>JIPPSFacade</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>updateVerarbStat</method-name>
         <method-params>
            <method-param>ch.ige.jipps.vo.DruckPeriVO</method-param>
         </method-params>
      </method>
      <trans-attribute>RequiresNew</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_9">
      <method id="MethodElement_9">
         <ejb-name>JIPPSFacade</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>printAMVOne</method-name>
         <method-params>
            <method-param>boolean</method-param>
         </method-params>
      </method>
      <trans-attribute>Supports</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_10">
      <method id="MethodElement_10">
         <ejb-name>JIPPSFacade</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>printAMVOne</method-name>
         <method-params>
            <method-param>boolean</method-param>
            <method-param>int</method-param>
            <method-param>boolean</method-param>
         </method-params>
      </method>
      <trans-attribute>Supports</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_11">
      <method id="MethodElement_11">
         <ejb-name>JIPPSFacade</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>finishAMVOne</method-name>
         <method-params>
            <method-param>boolean</method-param>
            <method-param>int</method-param>
            <method-param>boolean</method-param>
         </method-params>
      </method>
      <trans-attribute>Supports</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_12">
      <method id="MethodElement_12">
         <ejb-name>JIPPSFacade</ejb-name>
         <method-intf>Remote</method-intf>
         <method-name>printAMVChanges</method-name>
         <method-params>
            <method-param>boolean</method-param>
         </method-params>
      </method>
      <trans-attribute>Supports</trans-attribute>
   </container-transaction>
   <container-transaction id="MethodTransaction_13">
      <method id="MethodElement_13">
         <ejb-name>AmvTransactionManager</ejb-name>
          <method-name>*</method-name>
       </method>
       <trans-attribute>RequiresNew</trans-attribute>
    </container-transaction>

   <!-- finder transactions -->

   <!-- message destinations -->
     <!--
       To specify additional message-destination elements, add a file in the merge
       directory called ejb-message-destinations.ent that contains them.
     -->

   <!-- exclude list -->
     <!--
       To specify an exclude-list element, add a file in the merge directory
       called ejb-exclude-list.xml that contains it.
     -->
   </assembly-descriptor>

</ejb-jar>

'
]

{ #category : #elements }
JEETestModels >> parameterCalled: aString belongsTo: aBehaviouralEntity with: aDeclaredType [
	|parameter|

	parameter := FAMIXParameter new
		name: aString;
		parentBehaviouralEntity: aBehaviouralEntity;
		declaredType: aDeclaredType;
		yourself.
	
	^parameter
]

{ #category : #accessing }
JEETestModels >> root [
	^root
]

{ #category : #models }
JEETestModels >> sampleMooseModel [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean acmpEntity |
	
	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aStatelessSessionBean addMethod: (FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.
	aStatefulSessionBean
			addMethod: (FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;
				yourself
			).
	
	acmpEntity := FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself.
	
	acmpEntity 
		addAttribute: (FAMIXAttribute new 
			name: 'Att1';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att2';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att3';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att4';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		).

		
	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		add: aPackage;
		add: anotherPackage;
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
		add: acmpEntity;
		addAll: acmpEntity attributes; 
		add: (FAMIXClass new
			name: #ACMPEntity;
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

{ #category : #models }
JEETestModels >> sampleMooseModelContainingABiggerDB [
	
	| mooseModel importer |

	mooseModel := MooseModel new.
	mooseModel name: 'testDataBase'.
	
	PPParserResource reset.
	
	importer := MJSQLImporterFromVisitor on: mooseModel.
	
	^importer importSQLCreateScriptFrom: self fiveTablesConnectedThroughForeignKey.
]

{ #category : #models }
JEETestModels >> sampleMooseModelContainingJustADB [
	
	| mooseModel importer |

	mooseModel := MooseModel new.
	mooseModel name: 'testDataBase'.
	
	PPParserResource reset.
	
	importer := MJSQLImporterFromVisitor on: mooseModel.
	
	^importer importSQLCreateScriptFrom: self threeTablesConnectedThroughForeignKey.
]

{ #category : #models }
JEETestModels >> sampleMooseModelWithDB [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean database dbTable1 dbTable2 dbTable3 tableColumn1 tableColumn2 tableColumn3 tableColumn5 tableColumn6 tableColumn4 acmpEntity |
	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aStatelessSessionBean addMethod: (FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.
	aStatefulSessionBean
			addMethod: (FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;
				yourself
			).
	
	acmpEntity := FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself.
	
	acmpEntity 
		addAttribute: (FAMIXAttribute new 
			name: 'Att1';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att2';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att3';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att4';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		).

	
	"instanciating relational elements"
	database := FAMIXDataBase new name: #database1.

	dbTable1 := FAMIXTable new
			name: 'Table1';
			ownerDataBase: database.
	
	dbTable2 := FAMIXTable new
			name: 'Table2';
			ownerDataBase: database.

	dbTable3 := FAMIXTable new
			name: 'Table3';
			ownerDataBase: database.

	tableColumn1 := FAMIXColumn new
						name: #Column2;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: false;
						type: 'integer'.
	
	tableColumn2 := FAMIXColumn new
						name: #Column4;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: true;
						isUnique: true;
						type: 'string'.
	
	tableColumn3 := FAMIXColumn new
						name: #Column6;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: false;
						isUnique: false;
						type: 'integer'.
						
	dbTable1 addColumn: tableColumn1.
	dbTable1 addColumn: tableColumn2.
	dbTable1 addColumn: tableColumn3.
	
	
	tableColumn4 := FAMIXColumn new
						name: #Column1;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable2;
						type: 'integer'.
	
	tableColumn5 := FAMIXColumn new
						name: #Column3;
						isPK: false;
						isFK: true;
						ownerTable:  dbTable2;
						type: 'integer'.
	
	dbTable2 addColumn: tableColumn4.
	dbTable2 addColumn: tableColumn5.
						
	tableColumn6 := FAMIXColumn new
						name: #Column5;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable3;
						type: 'integer'.
	
	dbTable3 addColumn: tableColumn6.

	database addTable: dbTable1.
 	database addTable: dbTable2.
	database addTable: dbTable3.
		
	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		add: aPackage;
		add: anotherPackage;
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
		add: acmpEntity;
		addAll: acmpEntity attributes; 
		add: (FAMIXClass new
			name: #ACMPEntity;
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
		);
		add: database;
		addAll: database tables;
		addAll: dbTable1 columns;
		addAll: dbTable2 columns;
		addAll: dbTable3 columns.

	^mooseModel
]

{ #category : #models }
JEETestModels >> sampleMooseModelWithInvocation [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod |

	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatelessSessionBean;
				signature: #someMethod asString;
				yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatelessSessionBean;
				signature: #someOtherMethod asString;
				yourself.
	
	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod).

	invocation := FAMIXInvocation new receiver: aMethod; addCandidate: someMethod ; yourself.
	aMethod addOutgoingInvocation: invocation.
	someMethod addIncomingInvocation: invocation.	

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransAndQuery [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute invocation6 |

	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

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

	methodThatExecute := FAMIXMethod new
						name: #executeBatch;
						parentType: aStatefulSessionBean;
						signature: #executeBatch;
						yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod;
				yourself.

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod);
			addMethod: (methodThatExecute).

	class3 := FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				signature: #aMethod;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				ejbTransactionType: 'Required';
				signature: #aMethod;
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class4;
				ejbTransactionType: 'Required';
				signature: #aMethod;
				yourself.

	method4 := FAMIXMethod new
				name: #method4;
				parentType: class4;
				signature: #aMethod;
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2).

	class4	addMethod: (method3);
			addMethod: (method4).

	invocation := FAMIXInvocation new receiver: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation.
	someMethod addIncomingInvocation: invocation.	

	invocation2 := FAMIXInvocation new receiver: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation2.
	aMethod addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new receiver: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation3.
	aMethod addIncomingInvocation: invocation3.

	invocation4 := FAMIXInvocation new receiver: method3; addCandidate: method1 ; signature: #method1 ;yourself.
	method3 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new receiver: method4; addCandidate: method2 ; signature: #method2 ;yourself.
	method4 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	"invocation to method that executes a queryes"
	invocation6 := FAMIXInvocation new receiver: someMethod; addCandidate: methodThatExecute ; signature: #executeBatch ;yourself.
	someMethod addOutgoingInvocation: invocation6.
	methodThatExecute addIncomingInvocation: invocation6.

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransAndQueryAndBeans [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute invocation6 class1 class2 class5 class6 inheritance |

	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				yourself.

	methodThatExecute := FAMIXMethod new
						name: #executeBatch;
						parentType: aStatefulSessionBean;
						yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				yourself.

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod);
			addMethod: (methodThatExecute).

	class1 := FAMIXClass new
			name: #Class1;
			container: aPackage;
			yourself.
	class2 := FAMIXClass new
			name: #Class2;
			container: aPackage;
			yourself.
	class5 := FAMIXClass new
			name: #Class5;
			container: aPackage;
			yourself.
	class6 := FAMIXClass new
			name: #Class6;
			container: aPackage;
			yourself.

	class3 := FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	inheritance := FAMIXInheritance new 
					superclass: class6; 
					subclass: class3.

	class3 addSuperInheritance: inheritance.
	class6 addSubInheritance: inheritance.

	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				ejbTransactionType: 'Required';
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class4;
				ejbTransactionType: 'Required';
				yourself.

	method4 := FAMIXMethod new
				name: #method4;
				parentType: class4;
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2).

	class4	addMethod: (method3);
			addMethod: (method4).

	invocation := FAMIXInvocation new sender: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation.
	someMethod addIncomingInvocation: invocation.	

	invocation2 := FAMIXInvocation new sender: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation2.
	aMethod addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation3.
	aMethod addIncomingInvocation: invocation3.

	invocation4 := FAMIXInvocation new sender: method3; addCandidate: method1 ; signature: #method1 ;yourself.
	method3 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new sender: method4; addCandidate: method2 ; signature: #method2 ;yourself.
	method4 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	"invocation to method that executes a queryes"
	invocation6 := FAMIXInvocation new sender: someMethod; addCandidate: methodThatExecute ; signature: #executeBatch ;yourself.
	someMethod addOutgoingInvocation: invocation6.
	methodThatExecute addIncomingInvocation: invocation6.

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
		add: class1;
		add: class2;
		add: class3;
		add: class4;
		add: class5;
		add: class6;
		add: inheritance;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (MJFAMIXSessionBean new
			name: #AStatelessSession;
			implementationClass: aStatelessSessionBean;
			yourself
		);
		add: aStatelessSessionBean;
		add: (MJFAMIXSessionBean new
			name: #AStatefulSessionHome;
			implementationClass: aStatefulSessionBean;
			yourself
		);
		add: (MJFAMIXSessionBean new
			name: #AStatefulSession;
			implementationClass: class3;
			yourself
		);
		add: aStatefulSessionBean;
		add: (MJFAMIXEntityBean new
			name: #ACMPEntityHome;
			implementationClass: class4;
			yourself
		);
		add: (MJFAMIXEntityBean new
			name: #ACMPEntity;
			implementationClass: class1;
			yourself
		);
		add: (MJFAMIXEntityBean new
			name: #ACMPEntityBean;
			implementationClass: class2;
			yourself
		);
		add: (MJFAMIXMessageDrivenBean new
			name: #ACMPMessagePK;
			implementationClass: class5;
			yourself
		);
		add: (MJFAMIXMessageDrivenBean new
			name: #ABMPMessageHome;
			implementationClass: class6;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransAndQueryAndBeansAndHierarchi [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute invocation6 class1 class2 class5 class6 inheritance java sql prepareStatement |

	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	java := FAMIXNamespace new
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
							yourself.

	prepareStatement addMethod: (methodThatExecute).

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				yourself.

	methodThatExecute := FAMIXMethod new
						name: #executeBatch;
						parentType: aStatefulSessionBean;
						yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				yourself.

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod).

	class1 := FAMIXClass new
			name: #Class1;
			container: aPackage;
			yourself.
	class2 := FAMIXClass new
			name: #Class2;
			container: aPackage;
			isInterface: true;
			yourself.
	class5 := FAMIXClass new
			name: #Class5;
			container: aPackage;
			yourself.
	class6 := FAMIXClass new
			name: #Class6;
			container: aPackage;
			isInterface: true;
			yourself.

	class3 := FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	inheritance := FAMIXInheritance new 
					superclass: class6; 
					subclass: class3.

	class3 addSuperInheritance: inheritance.
	class6 addSubInheritance: inheritance.

	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.
	
	inheritance := FAMIXInheritance new 
					superclass: class2; 
					subclass: class4.

	class4 addSuperInheritance: inheritance.
	class2 addSubInheritance: inheritance.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				ejbTransactionType: 'Required';
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class4;
				ejbTransactionType: 'Required';
				yourself.

	method4 := FAMIXMethod new
				name: #method4;
				parentType: class4;
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2).

	class4	addMethod: (method3);
			addMethod: (method4).

	invocation := FAMIXInvocation new sender: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation.
	someMethod addIncomingInvocation: invocation.	

	invocation2 := FAMIXInvocation new sender: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation2.
	aMethod addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation3.
	aMethod addIncomingInvocation: invocation3.

	invocation4 := FAMIXInvocation new sender: method3; addCandidate: method1 ; signature: #method1 ;yourself.
	method3 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new sender: method4; addCandidate: method2 ; signature: #method2 ;yourself.
	method4 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	"invocation to method that executes a queryes"
	invocation6 := FAMIXInvocation new sender: someMethod; addCandidate: methodThatExecute ; signature: #executeBatch ;yourself.
	someMethod addOutgoingInvocation: invocation6.
	methodThatExecute addIncomingInvocation: invocation6.

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		addAll: prepareStatement methods;
		add: java;
		add: sql;	
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
		add: class1;
		add: class2;
		add: class3;
		add: class4;
		add: class5;
		add: class6;
		add: inheritance;
		add: prepareStatement;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (MJFAMIXSessionBean new
			name: #AStatelessSession;
			implementationClass: aStatelessSessionBean;
			yourself
		);
		add: aStatelessSessionBean;
		add: (MJFAMIXSessionBean new
			name: #AStatefulSessionHome;
			implementationClass: aStatefulSessionBean;
			yourself
		);
		add: (MJFAMIXEntityBean new
			name: #AStatefulSession;
			implementationClass: class3;
			yourself
		);
		add: aStatefulSessionBean;
		add: (MJFAMIXSessionBean new
			name: #ACMPEntityHome;
			implementationClass: class6;
			yourself
		);
		add: (MJFAMIXEntityBean new
			name: #ACMPEntity;
			implementationClass: class1;
			yourself
		);
		add: (MJFAMIXEntityBean new
			name: #ACMPEntityBean;
			yourself
		);
		add: (MJFAMIXMessageDrivenBean new
			name: #ACMPMessagePK;
			implementationClass: class5;
			yourself
		);
		add: (MJFAMIXMessageDrivenBean new
			name: #ABMPMessageHome;
			implementationClass: class4;
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
			name: #PAOEntity;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransAndQueryComplex [

	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute method5 method6 method7 method9 method10 method11 method12 method13 method14 method8 invocation6 invocation7 invocation8 invocation9 invocation10 invocation11 invocation12 invocation13 invocation14 invocation15 invocation16 invocation17 invocation18 invocation19 |

	mooseModel := MooseModel new.

	aPackage := FAMIXNamespace new
				name: #aPackage;
				yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;	
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;	
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;	
				yourself.

	methodThatExecute := FAMIXMethod new
						name: #executeBatch;
						parentType: aStatefulSessionBean;
						signature: #executeBatch asString;	
						yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;	
				yourself.

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod);
			addMethod: (methodThatExecute).

	class3 :=  FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				signature: #method1 asString;	
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				signature: #method2 asString;	
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class3;
				signature: #method3 asString;	
				yourself.
				
	method4 := FAMIXMethod new
				name: #method4;
				parentType: class3;
				signature: #method4 asString;	
				yourself.

	method5 := FAMIXMethod new
				name: #method5;
				parentType: class3;
				signature: #method5 asString;	
				yourself.

	method6 := FAMIXMethod new
				name: #method6;
				parentType: class3;
				signature: #method6 asString;	
				yourself.

	method7 := FAMIXMethod new
				name: #method7;
				parentType: class3;
				signature: #method7 asString;	
				ejbTransactionType: 'Required';
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method4);
			addMethod: (method5);
			addMethod: (method6);
			addMethod: (method7).


	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method8 := FAMIXMethod new
				name: #method8;
				parentType: class4;
				signature: #method8 asString;	
				ejbTransactionType: 'Required';
				yourself.
	
	method9 := FAMIXMethod new
				name: #method9;
				parentType: class4;
				signature: #method9 asString;	
				yourself.

	method10 := FAMIXMethod new
				name: #method10;
				parentType: class4;
				signature: #method10 asString;	
				yourself.
	method11 := FAMIXMethod new
				name: #method11;
				parentType: class4;
				signature: #method11 asString;	
				ejbTransactionType: 'Required';
				yourself.

	method12 := FAMIXMethod new
				name: #method12;
				parentType: class4;
				signature: #method12 asString;	
				yourself.

	method13 := FAMIXMethod new
				name: #method13;
				parentType: class4;
				signature: #method13 asString;	
				yourself.

	method14 := FAMIXMethod new
				name: #method14;
				parentType: class4;
				signature: #method14 asString;	
				ejbTransactionType: 'Required';
				yourself.

	class4	addMethod: (method8);
			addMethod: (method3);
			addMethod: (method9);
			addMethod: (method10);
			addMethod: (method11);
			addMethod: (method12);
			addMethod: (method13);
			addMethod: (method14).

	"invocation to method that executes a queryes"
	invocation := FAMIXInvocation new sender: method1; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method1 addOutgoingInvocation: invocation.
	methodThatExecute addIncomingInvocation: invocation.

	invocation2 := FAMIXInvocation new sender: method2; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method2 addOutgoingInvocation: invocation2.
	methodThatExecute addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method3; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method3 addOutgoingInvocation: invocation3.
	methodThatExecute addIncomingInvocation: invocation3.

	"other invocation"
	invocation4 := FAMIXInvocation new sender: method4; addCandidate: method1; signature: #method1; yourself.
	method4 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new sender: method5; addCandidate: method2 ; signature: #method2; yourself.
	method5 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	invocation6 := FAMIXInvocation new sender: method5; addCandidate: method6 ; signature: #method6; yourself.
	method5 addOutgoingInvocation: invocation6.
	method6 addIncomingInvocation: invocation6.

	invocation7 := FAMIXInvocation new sender: method6; addCandidate: method2 ; signature: #method2; yourself.
	method6 addOutgoingInvocation: invocation7.
	method2 addIncomingInvocation: invocation7.

	invocation8 := FAMIXInvocation new sender: method8; addCandidate: method4 ; signature: #method4; yourself.
	method8 addOutgoingInvocation: invocation8.
	method4 addIncomingInvocation: invocation8.

	invocation9 := FAMIXInvocation new sender: method9; addCandidate: method4 ; signature: #method4; yourself.
	method9 addOutgoingInvocation: invocation9.
	method4 addIncomingInvocation: invocation9.

	invocation10 := FAMIXInvocation new sender: method10; addCandidate: method6 ; signature: #method6; yourself.
	method10 addOutgoingInvocation: invocation10.
	method6 addIncomingInvocation: invocation10.

	invocation11 := FAMIXInvocation new sender: method11; addCandidate: method6 ; signature: #method6; yourself.
	method11 addOutgoingInvocation: invocation11.
	method6 addIncomingInvocation: invocation11.

	invocation12 := FAMIXInvocation new sender: method11; addCandidate: method1 ; signature: #method1; yourself.
	method11 addOutgoingInvocation: invocation12.
	method1 addIncomingInvocation: invocation12.

	invocation13 := FAMIXInvocation new sender: method14; addCandidate: method10 ; signature: #method10; yourself.
	method14 addOutgoingInvocation: invocation13.
	method10 addIncomingInvocation: invocation13.

	invocation14 := FAMIXInvocation new sender: method7; addCandidate: method3 ; signature: #method3 ;yourself.
	method7 addOutgoingInvocation: invocation14.
	method3 addIncomingInvocation: invocation14.

	invocation15 := FAMIXInvocation new sender: method12; addCandidate: method7 ; signature: #method7 ;yourself.
	method12 addOutgoingInvocation: invocation15.
	method7 addIncomingInvocation: invocation15.

	invocation16 := FAMIXInvocation new sender: method13; addCandidate: method7 ; signature: #method7 ;yourself.
	method13 addOutgoingInvocation: invocation16.
	method7 addIncomingInvocation: invocation16.

	"old invocations"
	invocation17 := FAMIXInvocation new sender: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation17.
	someMethod addIncomingInvocation: invocation17.	

	invocation18 := FAMIXInvocation new sender: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation18.
	aMethod addIncomingInvocation: invocation18.

	invocation19 := FAMIXInvocation new sender: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation19.
	aMethod addIncomingInvocation: invocation19.


	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
		add: invocation6;
		add: invocation7;
		add: invocation8;
		add: invocation9;
		add: invocation10;
		add: invocation11;
		add: invocation12;
		add: invocation13;
		add: invocation14;
		add: invocation15;
		add: invocation16;
		add: invocation17;
		add: invocation18;
		add: invocation19;
		add: class3;
		add: class4;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction [

	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute method5 method6 method7 method9 method10 method11 method12 method13 method14 method8 invocation6 invocation7 invocation8 invocation9 invocation10 invocation11 invocation12 invocation13 invocation14 invocation15 invocation16 invocation17 invocation18 invocation19 java sql prepareStatement |

	mooseModel := MooseModel new.

	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	java := FAMIXNamespace new
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

	prepareStatement addMethod: (methodThatExecute).

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

	class3 := FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				signature: #method1;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				signature: #method2;
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class3;
				signature: #method3;
				ejbTransactionType: 'RequiresNew';
				yourself.

	method4 := FAMIXMethod new
				name: #method4;
				parentType: class3;
				signature: #method4;
				yourself.

	method5 := FAMIXMethod new
				name: #method5;
				parentType: class3;
				signature: #method5;
				yourself.

	method6 := FAMIXMethod new
				name: #method6;
				parentType: class3;
				ejbTransactionType: 'RequiresNew';
				signature: #method6;
				yourself.

	method7 := FAMIXMethod new
				name: #method7;
				parentType: class3;
				signature: #method7;
				ejbTransactionType: 'Required';
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method3);
			addMethod: (method4);
			addMethod: (method5);
			addMethod: (method6);
			addMethod: (method7).


	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method8 := FAMIXMethod new
				name: #method8;
				parentType: class4;
				ejbTransactionType: 'Required';
				signature: #method8;
				yourself.
	
	method9 := FAMIXMethod new
				name: #method9;
				parentType: class4;
				signature: #method9;
				yourself.

	method10 := FAMIXMethod new
				name: #method10;
				parentType: class4;
				signature: #method10;
				yourself.
	method11 := FAMIXMethod new
				name: #method11;
				parentType: class4;
				ejbTransactionType: 'Required';
				signature: #method11;
				yourself.

	method12 := FAMIXMethod new
				name: #method12;
				parentType: class4;
				signature: #method12;
				yourself.

	method13 := FAMIXMethod new
				name: #method13;
				parentType: class4;
				signature: #method13;
				yourself.

	method14 := FAMIXMethod new
				name: #method14;
				parentType: class4;
				ejbTransactionType: 'Required';
				signature: #method14;
				yourself.

	class4	addMethod: (method8);
			addMethod: (method9);
			addMethod: (method10);
			addMethod: (method11);
			addMethod: (method12);
			addMethod: (method13);
			addMethod: (method14).

	"invocation to method that executes a queryes"
	invocation := FAMIXInvocation new sender: method1; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method1 addOutgoingInvocation: invocation.
	methodThatExecute addIncomingInvocation: invocation.

	invocation2 := FAMIXInvocation new sender: method2; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method2 addOutgoingInvocation: invocation2.
	methodThatExecute addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method3; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method3 addOutgoingInvocation: invocation3.
	methodThatExecute addIncomingInvocation: invocation3.

	"other invocation"
	invocation4 := FAMIXInvocation new sender: method4; addCandidate: method1; signature: #method1; yourself.
	method4 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new sender: method5; addCandidate: method2 ; signature: #method2; yourself.
	method5 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	invocation6 := FAMIXInvocation new sender: method5; addCandidate: method6 ; signature: #method6; yourself.
	method5 addOutgoingInvocation: invocation6.
	method6 addIncomingInvocation: invocation6.

	invocation7 := FAMIXInvocation new sender: method6; addCandidate: method2 ; signature: #method2; yourself.
	method6 addOutgoingInvocation: invocation7.
	method2 addIncomingInvocation: invocation7.

	invocation8 := FAMIXInvocation new sender: method8; addCandidate: method4 ; signature: #method4; yourself.
	method8 addOutgoingInvocation: invocation8.
	method4 addIncomingInvocation: invocation8.

	invocation9 := FAMIXInvocation new sender: method9; addCandidate: method4 ; signature: #method4; yourself.
	method9 addOutgoingInvocation: invocation9.
	method4 addIncomingInvocation: invocation9.

	invocation10 := FAMIXInvocation new sender: method10; addCandidate: method6 ; signature: #method6; yourself.
	method10 addOutgoingInvocation: invocation10.
	method6 addIncomingInvocation: invocation10.

	invocation11 := FAMIXInvocation new sender: method11; addCandidate: method6 ; signature: #method6; yourself.
	method11 addOutgoingInvocation: invocation11.
	method6 addIncomingInvocation: invocation11.

	invocation12 := FAMIXInvocation new sender: method11; addCandidate: method1 ; signature: #method1; yourself.
	method11 addOutgoingInvocation: invocation12.
	method1 addIncomingInvocation: invocation12.

	invocation13 := FAMIXInvocation new sender: method14; addCandidate: method10 ; signature: #method10; yourself.
	method14 addOutgoingInvocation: invocation13.
	method10 addIncomingInvocation: invocation13.

	invocation14 := FAMIXInvocation new sender: method7; addCandidate: method3 ; signature: #method3 ;yourself.
	method7 addOutgoingInvocation: invocation14.
	method3 addIncomingInvocation: invocation14.

	invocation15 := FAMIXInvocation new sender: method12; addCandidate: method7 ; signature: #method7 ;yourself.
	method12 addOutgoingInvocation: invocation15.
	method7 addIncomingInvocation: invocation15.

	invocation16 := FAMIXInvocation new sender: method13; addCandidate: method7 ; signature: #method7 ;yourself.
	method13 addOutgoingInvocation: invocation16.
	method7 addIncomingInvocation: invocation16.

	"old invocations"
	invocation17 := FAMIXInvocation new sender: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation17.
	someMethod addIncomingInvocation: invocation17.	

	invocation18 := FAMIXInvocation new sender: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation18.
	aMethod addIncomingInvocation: invocation18.

	invocation19 := FAMIXInvocation new sender: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation19.
	aMethod addIncomingInvocation: invocation19.


	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		addAll: prepareStatement methods;
		add: java;
		add: sql;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
		add: invocation6;
		add: invocation7;
		add: invocation8;
		add: invocation9;
		add: invocation10;
		add: invocation11;
		add: invocation12;
		add: invocation13;
		add: invocation14;
		add: invocation15;
		add: invocation16;
		add: invocation17;
		add: invocation18;
		add: invocation19;
		add: class3;
		add: class4;
		add: prepareStatement;
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

{ #category : #models }
JEETestModels >> sampleMooseModelWithTransaction [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 |

	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

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
				parentType: aStatelessSessionBean;
				signature: #someMethod;
				yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatelessSessionBean;
				signature: #someOtherMethod;
				yourself.
	
	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod).

	class3 := FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				signature: #method1;
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				signature: #method2;
				ejbTransactionType: 'Required';
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class4;
				signature: #method3;
				ejbTransactionType: 'Required';
				yourself.

	method4 := FAMIXMethod new
				name: #method4;
				parentType: class4;
				signature: #method4;
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2).

	class4	addMethod: (method3);
			addMethod: (method4).

	invocation := FAMIXInvocation new receiver: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation.
	someMethod addIncomingInvocation: invocation.	

	invocation2 := FAMIXInvocation new receiver: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation2.
	aMethod addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new receiver: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation3.
	aMethod addIncomingInvocation: invocation3.

	invocation4 := FAMIXInvocation new receiver: method3; addCandidate: method1 ; signature: #method1 ;yourself.
	method3 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new receiver: method4; addCandidate: method2 ; signature: #method2 ;yourself.
	method4 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
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

{ #category : #initialize }
JEETestModels >> setRootFrom: aString [
	| parser factory doc |

	parser := XMLDOMParser on: aString readStream.
	factory := XMLPluggableElementFactory new
				elementClass: MJEJBeanElement;
				handleElement: 'entity' withClass: MJEntityElement;
				handleElement: 'message-driven' withClass: MJMessageDrivenElement;
				handleElement: 'session' withClass: MJSessionElement;
				handleElement: 'container-transaction' withClass: MJContainerTransactionElement.

	parser nodeFactory: factory.  

	doc := parser parseDocument.
	^doc root.
]

{ #category : #elements }
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

{ #category : #elements }
JEETestModels >> testNamespace [

	| namespace |

	namespace := FAMIXNamespace new
			name: #testNamespace;
			yourself.

	^namespace 
]

{ #category : #elements }
JEETestModels >> threeTablesConnectedThroughForeignKey [

^'CREATE TABLE A_Asset(
    A_Asset_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID                 NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Org_ID                    NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    Created                      DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                    NUMBER(10, 0)      NOT NULL,
    Updated                      DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                    NUMBER(10, 0)      NOT NULL,
    Value                        NVARCHAR2(40)      NOT NULL,
    Name                         NVARCHAR2(60)      NOT NULL,
    Description                  NVARCHAR2(255),
    Help                         NVARCHAR2(2000),
    A_Asset_Group_ID             NUMBER(10, 0)      NOT NULL,
    Parent_Asset_ID              NUMBER(10, 0),
    M_Product_ID                 NUMBER(10, 0),
    M_AttributeSetInstance_ID    NUMBER(10, 0),
    C_UOM_ID                     NUMBER(10, 0),
    SerNo                        NVARCHAR2(40),
    Lot                          NVARCHAR2(40),
    VersionNo                    NVARCHAR2(40),
    GuaranteeDate                DATE               NOT NULL,
    AssetServiceDate             DATE               NOT NULL,
    AssetDisposalDate            DATE               NOT NULL,
    LocationComment              NVARCHAR2(255),
    M_Locator_ID                 NUMBER(10, 0),
    C_BPartner_ID                NUMBER(10, 0),
    C_BPartner_Location_ID       NUMBER(10, 0),
    AD_User_ID                   NUMBER(10, 0),
    C_Location_ID                NUMBER(10, 0),
    LastMaintenanceDate          DATE               NOT NULL,
    NextMaintenanceDate          DATE               NOT NULL,
    LastMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    NextMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    Lease_BPartner_ID            NUMBER(10, 0),
    LeaseTerminationDate         DATE               NOT NULL,
    Processing                   CHAR(1)
);

CREATE TABLE A_Asset_Group(
    A_Asset_Group_ID    NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID        NUMBER(10, 0)      NOT NULL,
    AD_Org_ID           NUMBER(10, 0)      NOT NULL,
    Created             DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy           NUMBER(10, 0)      NOT NULL,
    Updated             DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy           NUMBER(10, 0)      NOT NULL,
    Name                NVARCHAR2(60)      NOT NULL,
    Description         NVARCHAR2(255),
    Help                NVARCHAR2(2000),
    CONSTRAINT A_Asset_Group_Key PRIMARY KEY (A_Asset_Group_ID)
);

CREATE TABLE AD_User(
    AD_User_ID                NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID              NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Org_ID                 NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    Created                   DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                 NUMBER(10, 0)      NOT NULL,
    Updated                   DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                 NUMBER(10, 0)      NOT NULL,
    Name                      NVARCHAR2(60)      NOT NULL,
    Title                     NVARCHAR2(40)      NOT NULL,
    C_Greeting_ID             NUMBER(10, 0),
    Description               NVARCHAR2(255),
    Comments                  NVARCHAR2(2000),
    C_BPartner_ID             NUMBER(10, 0),
    C_BPartner_Location_ID    NUMBER(10, 0),
    Password                  NVARCHAR2(40)      NOT NULL,
    EMail                     NVARCHAR2(60),
    EMailVerify               NVARCHAR2(40)      NOT NULL,
    Phone                     NVARCHAR2(40)      NOT NULL,
    Phone2                    NVARCHAR2(40)      NOT NULL,
    EMailUser                 NVARCHAR2(20)      NOT NULL,
    EMailUserPW               NVARCHAR2(20)      NOT NULL,
    Fax                       NVARCHAR2(40)      NOT NULL,
    Birthday                  DATE               NOT NULL,
    Supervisor_ID             NUMBER(10, 0),
    AD_OrgTrx_ID              NUMBER(10, 0),
    PA_Goal_ID                NUMBER(10, 0),
    PA_GoalPrivate_ID         NUMBER(10, 0),
    LastContact               DATE               NOT NULL,
    LastResult                NVARCHAR2(255),
    Processing                CHAR(1),
    CONSTRAINT AD_User_Key PRIMARY KEY (AD_User_ID)
);

ALTER TABLE A_Asset ADD CONSTRAINT AAssetGroup_AAsset 
    FOREIGN KEY (A_Asset_Group_ID)
    REFERENCES A_Asset_Group(A_Asset_Group_ID);

ALTER TABLE A_Asset ADD CONSTRAINT ADUser_AAsset 
    FOREIGN KEY (AD_User_ID)
    REFERENCES AD_User(AD_User_ID)'

]
