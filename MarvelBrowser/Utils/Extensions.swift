//
//  Extensions.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation

public func + <KeyType, ValueType> (left: [KeyType: ValueType], right: [KeyType: ValueType]) -> [KeyType: ValueType] {
  
    var out = left

    for (k, v) in right {
        out.updateValue(v, forKey: k)
    }

    return out
}
