public class ListExample {
    
    Public Set<Student> Stu{Set;get;}
    Public List<Student> result{set ; get;}
    Public ListExample()
    {
         result= new List<Student>();
        Student s1= new Student('raj','27');
        Student s2= new Student('raj','27');
        Student s3=new Student('aaa','25');
        Student s4=new Student('bbb','256');
        Stu=new Set<Student>();
        
        
        result.add(s1);
        result.add(s2);
        
        Stu.add(s3);
        Stu.add(s4);
    }

}