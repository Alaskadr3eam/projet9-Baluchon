//
//  DateExt.swift
//  newbaluchon
//
//  Created by Clément Martin on 06/07/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
