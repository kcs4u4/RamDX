public class ListSudent {
    Public List<Student1> result {set;get;}
    
    Public ListSudent(){
        result = new List<Student1>();
        Student1 s1= new Student1('ram',20);
        Student1 s2= new Student1('cpe',22);
        
       result.add(s1);
    }
}