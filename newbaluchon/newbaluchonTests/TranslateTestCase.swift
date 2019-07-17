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
        translate = Translate(translateServiceSession: TranslateService.shared)
    }
 
    func testTextSourceTranslateIsEmpty1() {
        
        let textSource = String()
        
        let result = translate.textSourceNotEmpty1(textSource: textSource)
        
        XCTAssertEqual(result,false)
    }
    
    func testTextSourceTranslateIsEmptyPlaceHolder1() {
        let textSource = "Placeholder"
        
        let result = translate.textSourceNotEmpty1(textSource: textSource)
        
        XCTAssertEqual(result,true)
    }
    
    func testTextSourceTranslateIsNotEmpty1() {
        let textSource = "Coucou"
        
        let result = translate.textSourceNotEmpty1(textSource: textSource)
        
        XCTAssertEqual(result,true)
    }

   func testSubmitTranslate() {
    let translate1 = Translate(translateServiceSession: TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
    
        let textSrouce = "coucou"
        let source = ""
        let target = ""
    
    translate1.submitTranslate(textSource: textSrouce, source: source, target: target)
    
    XCTAssertEqual(translate1.errorTranslate, NetworkError.emptyData.rawValue)

    }

    func testSubmitTranslate1() {
        let translate1 = Translate(translateServiceSession: TranslateService(translateSession: URLSessionFake(data: nil , response: nil, error: nil)))
        
        let textSrouce = "coucou"
        let source = ""
        let target = ""
        
        translate1.submitTranslate(textSource: textSrouce, source: source, target: target)
        
        XCTAssertEqual(translate1.errorTranslate, NetworkError.emptyData.rawValue)
       
    }

    func testSubmitTranslate2() {
        let translate1 = Translate(translateServiceSession: TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseOK, error: nil)))
        
        let textSrouce = "coucou"
        let source = ""
        let target = ""
        
        translate1.submitTranslate(textSource: textSrouce, source: source, target: target)
        
        XCTAssertNil(translate1.errorTranslate)
        XCTAssertEqual(translate1.translatedText, "Hello")
      
    }




}
