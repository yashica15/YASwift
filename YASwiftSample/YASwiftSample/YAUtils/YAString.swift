//
//  YAString.swift
//

import Foundation
import UIKit

extension String {
    
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) != nil
    }
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = Locale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    func isAlphaNumeric() -> Bool {
        if self.isEmpty {
            return false
        }
        
        if (self.components(separatedBy: CharacterSet.whitespacesAndNewlines).count > 1) {
            return false
        }
    
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        var letterCount = 0
        var digitCount = 0
        
        for uni in self.unicodeScalars {
            if letters.contains(UnicodeScalar(uni.value)!) {
                letterCount += 1
            } else if digits.contains(UnicodeScalar(uni.value)!) {
                digitCount += 1
            }
        }
        
        return (letterCount > 0 && digitCount > 0)
        //return (self.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet()) == "")
    }
    
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
   
    func isValidPassword() -> Bool {
        if self.isEmpty {
            return false
        }
        
        if (self.components(separatedBy: CharacterSet.whitespacesAndNewlines).count > 1) {
            return false
        }
        
        return true
    }
    
    func isMatchConfirmPassword(_ password : String) -> Bool {
        return (password == self)
    }
    
    func trimmedString() -> String {
        return (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
    
    func isValidURL() -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        
        let urlText = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        return urlText.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let nameRegEx = "[a-zA-z.\\s]+([ '-][a-zA-Z]+)*$"
        
        let nameText = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameText.evaluate(with: self)
    }
    
    func isValidUserName() -> Bool {
        let usernameRegEx = "^(?=.{1,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$"
        
        let userTest = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return userTest.evaluate(with: self)
    }
    
    func isValidZipcode() -> Bool {
        let zipRegEx = "([0-9]{6}|[0-9]{3}\\s[0-9]{3})"
        
        let zipText = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
        return zipText.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^+(?:[0-9] ?){6,14}[0-9]$"
        
        let phoneText = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneText.evaluate(with: self)
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
