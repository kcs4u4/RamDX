@isTest
public class DemoController_Test
{
    public static testMethod void someMethod_Test()
    {
        System.Test.StartTest();

        //Set Context for Current page in Test Method
       System.Test.setCurrentPage(Page.somepage);

        //... some code Here, which will produce error in Apex:PageMessages tag
        List<Apexpages.Message> msgs = ApexPages.getMessages();

        boolean isErrorMessage = false;

        for(Apexpages.Message msg : msgs){
            if (msg.getDetail().contains('User is not Authorized to perform this Operation') )
                isErrorMessage  = true;
        }
        //Assert that the Page Message was Properly Displayed
      //  system.assert(isErrorMessage );

    }
}