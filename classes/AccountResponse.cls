global class AccountResponse
{
	// bFO ID of Assessment
    WebService string ID { get; set; }
    
    // Name of the Assessment
    WebService string ACCOUNTID { get; set; }
    
    // Description of the Assessment
    WebService string ASSESSMENTID { get; set; }

    // Maximum Score of the Assessment
    WebService string QUESTION { get; set; }

    // Maximum Score of the Assessment
    WebService string QUESTIONText { get; set; }

    // Program of the Assessment
    WebService string ANSWER { get; set; }

    // Program of the Assessment
    WebService string ANSWERText { get; set; }

        
    // LastUpdatetdDate timestamp in bFO
    WebService Datetime SDH_VERSION { get; set; }
    
    public AccountResponse() {
       
    }
}