package ca.anygroup.validation;

public class PasswordValidation {
	public String passValidation;
	public boolean passValidation(String pass, String cpass) {
		boolean upper=false;
		boolean lower=false;
		boolean digit=false;
		
		
	if((pass.length()) != 0)	{
		if (pass.length() >= 8) {
			if (pass.equals(cpass)) {	
			} else {
				passValidation = "Password Dosenot match";
				return false;
			}
			for (int i = 0; i < pass.length(); i++) {
				if ((Character.isUpperCase(pass.charAt(i)))) {
					
					passValidation=null;
					upper = true;
					break;

				} else {
					passValidation = "Password Should Contain Atleast One UpperCase";
					
				}

			}
		} else {
			passValidation = "Password is too short";
			return false;
		}
	} else {
		passValidation = "Password Cannot be empty";
		return false;
	}
		for (int j = 0; j < pass.length(); j++) {
			if (Character.isLowerCase(pass.charAt(j))) {
				
				lower = true;
				break;
			
			} else {
				passValidation = "Password Should Contain Atleast One Lower Case";
				
			}
			
		}
		if(lower==true) {}
		else {
			return false;
		}
		for (int k = 0; k < pass.length(); k++) {
			if (Character.isDigit(pass.charAt(k))) {
				
				
				
				digit = true;
				break;
				
			} else {
				passValidation = "Password Should Contain Atleast One Numeric Character";
				
			}
		}
		if(upper && lower && digit == true) {
			return true;
		}
		else {
			return false;
		}
	}

}
