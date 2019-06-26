//
//  DoubleExt.swift
//  CountOnMe
//
//  Created by Clément Martin on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

extension Double {
    func formatToString() -> String {
        let isInteger = floor(self) == self
        let stringToReturn = isInteger ? "\(Int(self))" : "\(self)"
        return stringToReturn
    }
}
