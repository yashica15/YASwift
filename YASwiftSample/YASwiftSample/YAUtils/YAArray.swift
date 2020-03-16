//
//  YAArray.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

extension NSMutableArray {
    
}


extension Results {
    
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }

}

extension RealmSwift.List {
    
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
