//
//  Constant.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct Constant {
    // MARK: - PROPERTIES WEATHER
    //key: 2567298816d0d1f85b5a7edfdc58aa63,"aa9e109ce2968dabc49a4e7bda426532"
    static var weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    static var apiKeyWeather = "2567298816d0d1f85b5a7edfdc58aa63"
    static var dataWeatherHoliday = [WeatherHoliday]()
    static var unit = "metric"
    static var weatherUrlCity = URL(string: "http://bulk.openweathermap.org/sample/city.list.json.gz")!

    // MARK: - properties translate
    static var translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    static var apiKeyTranslate = "AIzaSyDX07xWgK_IQRN3wXHFBopwycC9AzachOU"

    // MARK: - properties moneyConvertEur
    static var moneyUrl = URL(string: "http://data.fixer.io/api/latest")!
    static var apiKeyMoney = "64c9be90700082a08ab21d1f2cef1132"

    // MARK: - properties moneyRecupArrayDevise
    static var deviseUrl = URL(string: "http://data.fixer.io/api/symbols")!
    static var apiKeyDevise = "64c9be90700082a08ab21d1f2cef1132"
    static var arrayDeviseSymbols = ["STD", "INR", "XOF", "FKP", "AUD", "AFN", "NAD", "SHP", "MOP", "SRD", "GGP", "JEP", "UAH", "KYD", "JMD", "USD", "KRW", "AED", "XCD", "RON", "MNT", "CUC", "BYN", "XDR", "XAF", "ARS", "BSD", "BWP", "PYG", "DOP", "PHP", "SZL", "XPF", "BAM", "CDF", "GBP", "TJS", "OMR", "GNF", "GYD", "MWK", "MGA", "KPW", "ANG", "MDL", "ETB", "DKK", "HTG", "LSL", "NIO", "TZS", "MUR", "CLF", "LVL", "UYU", "SGD", "EUR", "SAR", "UGX", "ISK", "IMP", "KMF", "ZAR", "SYP", "BTN", "THB", "BDT", "GTQ", "GMD", "BHD", "BYR", "COP", "BRL", "PKR", "MVR", "YER", "LAK", "MAD", "IRR", "NGN", "JOD", "HKD", "SBD", "BOB", "GEL", "BTC", "TWD", "MKD", "LRD", "RWF", "AWG", "UZS", "PAB", "SLL", "MMK", "ZWL", "CAD", "TOP", "SDG", "VEF", "GIP", "RUB", "KGS", "VUV", "HRK", "AOA", "BBD", "TMT", "CLP", "MXN", "JPY", "CHF", "SEK", "LYD", "VND", "TTD", "CZK", "GHS", "RSD", "ZMW", "XAU", "TRY", "FJD", "KHR", "NZD", "WST", "IQD", "LBP", "BND", "KWD", "HUF", "BMD", "QAR", "MYR", "ALL", "PEN", "PLN", "CNY", "EGP", "NOK", "IDR", "LKR", "SOS", "ILS", "DZD", "PGK", "AMD", "BIF", "AZN", "BGN", "BZD", "MZN", "CRC", "SCR", "LTL", "SVC", "HNL", "TND", "KZT", "MRO", "CUP", "CVE", "ERN", "NPR", "DJF", "XAG", "ZMK", "KES"]
    // MARK: - properties Segue
    static var segueSettingWeather = "enterCity"
    static var segueSettingHolidayWeather = "addCityHoliday"
    static var segueLanguageTableView = "choiceLanguage"
}
