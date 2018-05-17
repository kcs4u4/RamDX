public class RandDCtrl {
	@auraEnabled
    public static void setData(String strlist){
        system.debug('----'+strlist);
    }
    @auraEnabled
    public static map<string,string> getData(){
        map<string,string> dataMap = new map<string,string>();
        dataMap.put('name', 'Harin');
        return dataMap;
    }
}