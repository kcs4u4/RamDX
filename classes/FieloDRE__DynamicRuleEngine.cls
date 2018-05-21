/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class DynamicRuleEngine {
    global DynamicRuleEngine() {

    }
    @InvocableMethod(label='Submit record to DRE' description='')
    global static void calculate(List<FieloDRE.DynamicRuleEngine.DRESetting> DRESettings) {

    }
    global static void processRecords(Map<Id,SObject> mapRecords) {

    }
    global static void processRecords(Map<Id,SObject> mapRecords, FieloDRE__ObjectsToProcess__c p_CSObj) {

    }
global class DRESetting {
    @InvocableVariable(label='Parent Id' required=true)
    global String parentId;
    @InvocableVariable(label='Query records to process' required=true)
    global String queryToProcess;
    global DRESetting() {

    }
}
}
