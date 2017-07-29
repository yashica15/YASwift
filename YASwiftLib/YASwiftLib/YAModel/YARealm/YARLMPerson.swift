//
//  YARLMPerson.swift
//  YASwiftLib
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

// Picture model
class Picture: Object {
    dynamic var picture = UIImagePNGRepresentation(imageLogo!)! as NSData
    dynamic var owner: Person? // Properties can be optional
}

// Person model
class Person: Object {
    dynamic var name = ""
    dynamic var birthdate = NSDate(timeIntervalSince1970: 1)
    let pictures = List<Picture>()
}
