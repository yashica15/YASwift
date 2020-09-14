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

public extension Array where Element: Hashable {
    
    func set() -> Set<Array.Element> {
        return Set(self)
    }
    
    func isSubset(of array: Array) -> Bool {
        self.set().isSubset(of: array.set())
    }
    
    func isSuperset(of array: Array) -> Bool {
        self.set().isSuperset(of: array.set())
    }
    
    func commonElements(between array: Array) -> Array {
        let intersection = self.set().intersection(array.set())
        return intersection.map({ $0 })
    }
    
    func hasCommonElements(with array: Array) -> Bool {
        return self.commonElements(between: array).count >= 1 ? true : false
    }
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
