@IsTest 
public class ForgotPasswordControllerTest1 {

     @IsTest(SeeAllData=true) 
    public static void testForgotPasswordController1() {
    	// Instantiate a new controller with all parameters in the page
    	ForgotPasswordController controller = new ForgotPasswordController();
    	controller.method1();
}
}