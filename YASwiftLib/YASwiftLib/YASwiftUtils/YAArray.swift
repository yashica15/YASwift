//
//  YAArray.swift
//  Yashica Agrawal
//
//  Created by Yashica Agrawal on 12/31/15.
//  Copyright © 2015 Yashica Agrawal. All rights reserved.
//

import Foundation
import RealmSwift

extension NSMutableArray {
    
}


extension Results {
    
    func toArray() -> [T] {
        return self.map{$0}
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
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}
