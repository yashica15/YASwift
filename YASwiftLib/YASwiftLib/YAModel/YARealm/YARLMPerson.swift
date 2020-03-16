//
//  YARLMPerson.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

// Picture model
class Picture: Object {
    @objc dynamic var picture = imageLogo!.pngData()! as NSData
    @objc dynamic var owner: Person? // Properties can be optional
}

// Person model
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var birthdate = NSDate(timeIntervalSince1970: 1)
    let pictures = List<Picture>()
}
