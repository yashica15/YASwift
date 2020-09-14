//
//  YAString.swift
//

import Foundation
import UIKit

extension String {
    
    public func validateFormRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid: Bool = predicate.evaluate(with: self)
        return isValid
    }
    
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
        
        let passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
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
    
    public func containsSpecialCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) {
                return true
            } else {
                return false
            }
        } catch {
            debugPrint(error.localizedDescription)
            return true
        }
    }
    
    public func specialCharacterCount() -> Int {
        let characters = Array(self)
        var count : Int = 0
        for character in characters {
            if String(character).containsSpecialCharacters() {
                count+=1;
            }
        }
        return count
    }
    
    public func findId(first: Int, second: Int) -> Int {
        if (first == 1) {
            return 1;
        } else {
            /* The position returned by josephus(n - 1, k) is adjusted because the
             recursive call josephus(n - 1, k) considers the original position
             k%n + 1 as position 1 */
            return (findId(first: first-1, second: second) + second-1) % first + 1
        }
    }
    
    public mutating func trimmingCharactersFromString(_ string : String) {
        let cs = CharacterSet.init(charactersIn: string)
        self = self.trimmingCharacters(in: cs)
    }
    
    func hashTags() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive)
        {
            let string = self as NSString
            return regex.matches(in: self, options: [],
                                 range:NSRange(location: 0, length: string.length)).map
                {  string.substring(with:
                    $0.range).replacingOccurrences(
                        of: "#", with:"").lowercased() }
        }
        return []
    }
    
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func widthForView(font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        var cfWidth = label.frame.width
        if  cfWidth > width {
            cfWidth = width
        }
        return cfWidth
    }
    
    func heightForView(font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        var heightReturn = label.frame.height+10
        if heightReturn < 30 {
            heightReturn = 30
        }
        return heightReturn
    }
    
    func converHTMLString() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType : NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
