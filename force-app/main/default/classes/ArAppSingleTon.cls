public class ArAppSingleTon {
    public ArAppSingleTon() {}
    static String completeURL = '';

    public static String randomStringGenerator(){
        String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
        Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
        String randomUUID = EncodingUtil.convertToHex(hash);
        System.debug('randomUUID'+randomUUID.toUpperCase());
        return randomUUID.toUpperCase();
    }
    
    public static String randomCharGenerator(Integer len){
		Blob blobKey = crypto.generateAesKey(128);
		String key = EncodingUtil.convertToHex(blobKey);
		String chars = key.substring(0,len);
        System.debug('-------'+chars);
        return chars;
    }
    
    public static String encodeValue(String value,Integer len){
        Blob valueBlob = Blob.valueOf(value);
        String tempEncodedusermail = EncodingUtil.base64Encode(valueBlob);
        System.debug('tempEncodedusermail'+tempEncodedusermail); 
        System.debug('randomcharGenerator(len)+tempEncodedusermail+randomcharGenerator(len) ----'+randomcharGenerator(len)+tempEncodedusermail+randomcharGenerator(len));
        return  randomcharGenerator(len)+tempEncodedusermail+randomcharGenerator(len);     
        
    }
    public static String decodeValue(String encodedvalue,Integer len){ 
        encodedvalue= encodedvalue.subString(len,encodedvalue.length()-len);
        Blob b= EncodingUtil.base64Decode(encodedvalue); 
        String decodevalue= b.toString();
        System.debug('b-----------'+decodevalue);
        return decodevalue;
    }
    
}