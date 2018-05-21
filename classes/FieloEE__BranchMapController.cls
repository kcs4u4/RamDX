/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class BranchMapController {
    global List<FieloEE.BranchMapController.BranchMobileWrapper> lista {
        get;
        set;
    }
    global BranchMapController() {

    }
    @Deprecated
    global List<FieloEE.BranchMapController.BranchMobileWrapper> getBranchs(Double latitude, Double longitude) {
        return null;
    }
global class BranchMobileWrapper {
    global String address {
        get;
        set;
    }
    global Id id {
        get;
        set;
    }
    global Double latitude {
        get;
        set;
    }
    global Double longitude {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global BranchMobileWrapper(FieloEE__Branch__c branch) {

    }
}
}
