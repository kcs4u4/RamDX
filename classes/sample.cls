public class sample {

    public String qry{get;set;}

    public pageReference searchAndfind() {
        pageReference pg = new pageReference('http://www.google.com/search?q='+qry);
        pg.setRedirect(true);
        return pg;
    }       
}