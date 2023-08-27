package api.utility.date;


// this class is part of file CreateAccount , Feature: Create Account feature
public class GenerateData {

	// Here it has to be a static method in order for karate to call it
	public static String getEmail() {
		// This method is just creating random email with random numbers
		String prefix = "toto_email";
		String provider = "@tekschool.is";
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider;
		return email; 

	}
	//Generating rundom phone number with Area code of 202
	public static String getPhoneNumber() {
		String phoneNumber = "202";
		for (int i = 0; i < 7; i++) {
			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;
	}
	// enerate rundinm car plates
	public static String getLicensePlate() {
	String prefix = "ab";
	String provider = "123";
	int random = (int) (Math.random() * 100);
	String LicensePlate = prefix + random + provider;
	return LicensePlate; 
	}

	public static void main(String[] args) {
		
		String number = getPhoneNumber();
		System.out.println(number);
		System.out.println(number.length());
	

	}
}