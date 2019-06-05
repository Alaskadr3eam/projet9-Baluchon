//
//  Setting.swift
//  newbaluchon
//
//  Created by Clément Martin on 05/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class Setting {
    
    static var shared = Setting()
    
    private init () {}
    
    var languageSource = Language.init(name: "Francais", code: "fr")
    var languageTarget = Language.init(name: "Anglais", code: "En")
}
