//
//  YARLMManager.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import RealmSwift
import CocoaLumberjack

class YARLMManager {
    //MARK: Shared Instance
    static let rlmManager: YARLMManager = YARLMManager()

    lazy var realm :Realm = {
        var realm = try! Realm()
        //The config (YASwiftSample.realm) is printed
        DDLogDebug("realm.configuration : \(realm.configuration)")
        return realm
    }()

    func savePersonObject(objPerson:Person) -> Bool {
        var isSuccess = true
        do {
            // Save Person object
            self.realm.beginWrite()
            self.realm.add(objPerson)
            try self.realm.commitWrite()
        } catch let error as NSError {
            isSuccess = false
            fatalError(error.localizedDescription)
        }
        return isSuccess
    }
    
    func fetchPersonList() -> Results<Person> {
        do {
            // Fetch Person Results
            let persons: Results<Person> = self.realm.objects(Person.self)
            return persons
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func updatePersonObject(objPerson:Person, name:String, birthDate:NSDate) -> Bool {
        var isSuccess = true
        do {
            try self.realm.write {
                objPerson.name = name
                objPerson.birthdate = birthDate
            }
        } catch let error as NSError {
            isSuccess = false
            fatalError(error.localizedDescription)
        }
        return isSuccess
    }
    
    func deletePersonObject(objPerson:Person) -> Bool {
        var isSuccess = true
        do {
            // Delete Person object
            try self.realm.write {
                self.realm.delete(objPerson)
            }
        } catch let error as NSError {
            isSuccess = false
            fatalError(error.localizedDescription)
        }
        return isSuccess
    }

}
