//
//  TranslateTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon

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
    translate(textSource: "Bonjour", source: "FR", target: "EN")
        
        
        //XCTAssertEqual(translationData.data.translation[0].translatedText,"Hello")
    }

    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
