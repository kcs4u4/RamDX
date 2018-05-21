/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class FieldDependency_ctrl {
    @RemoteAction
    global static List<FDF.FieldDependency_ctrl.FieldDependecy> getAllFieldDependency2(String selectedObj, String selField) {
        return null;
    }
    @RemoteAction
    global static List<FDF.FieldDependency_ctrl.Option> getCustomFields(String selectedObject) {
        return null;
    }
    @RemoteAction
    global static List<FDF.FieldDependency_ctrl.FieldDependecy> initFields(String selectedObject) {
        return null;
    }
global class FieldDependecy {
}
global class Option implements System.Comparable {
    global String label {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global Option(String name, String label) {

    }
}
}
