//
//  TranslateTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon
import RealmSwift

class TranslateTestCase: XCTestCase {

    var translate: Translate!

    override func setUp() {
        super.setUp()
        translate = Translate()
    }
    func translate(textSource: String, source: String, target: String) {
        
    translate.submitTranslate(textSource: textSource, source: source, target: target)

    }

    func testTextSourceTranslateIsEmpty() {
        let textSource = String()
        
        let result = translate.textSourceNotEmpty(textSource: textSource)

        XCTAssertEqual(result,false)
    }

    func testTextSourceTranslateIsEmptyPlaceHolder() {
        let textSource = "Placeholder"
        
        let result = translate.textSourceNotEmpty(textSource: textSource)
        
        XCTAssertEqual(result,false)
    }

    func testTextSourceTranslateIsNotEmpty() {
        let textSource = "Coucou"
        
        let result = translate.textSourceNotEmpty(textSource: textSource)
        
        XCTAssertEqual(result,true)
    }

    func testSubmitTranslate() {
        let textSrouce = "coucou"
        let source = "FR"
        let target = "EN"
        
        translate.submitTranslate(textSource: textSrouce, source: source, target: target)
    }

    func testSubmitTranslateSourceTextIsEmpty() {
        let textSrouce = ""
        let source = "FR"
        let target = "EN"
        
        translate.submitTranslate(textSource: textSrouce, source: source, target: target)

    }



}
