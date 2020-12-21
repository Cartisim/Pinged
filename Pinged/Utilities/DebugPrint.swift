//
//  DebugPrint.swift
//  Cartisim
//
//  Created by Cole M on 11/13/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

public func print(_ object: AnyObject) {
    #if DEBUG
    Swift.print(object)
    #endif
}
