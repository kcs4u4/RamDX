/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class MenuUtil {
    global MenuUtil() {

    }
    webService static Id cloneMenu(Id menuId) {
        return null;
    }
    global static String exportMenus(Id programId, List<Id> menuIds, String placement) {
        return null;
    }
    global static FieloEE__Menu__c getCurrentMenu() {
        return null;
    }
    global static FieloEE.MenuUtil.MenusContainer getMenus(String section, List<String> fields, Id programId) {
        return null;
    }
    global static void importMenus(String xmlBody, Id programId, Boolean createInexistent) {

    }
global class MenusContainer {
    global Map<Id,List<FieloEE__Menu__c>> childMenusMap {
        get;
        set;
    }
    global List<FieloEE__Menu__c> parentMenus {
        get;
        set;
    }
}
}
