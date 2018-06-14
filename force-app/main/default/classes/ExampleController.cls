public class ExampleController {

    transient public DateTime DateandTime ;
    
    Public String getDateandTime(){
        if(DateandTime ==Null)
            DateandTime=System.now();
        return 'DateandTime'+DateandTime;
        
    }
}