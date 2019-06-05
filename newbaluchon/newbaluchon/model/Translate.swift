//
//  Translate.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct TranslationData: Codable {
    var data: [Translations]
}

struct Translations: Codable {
    var translatedText: String
}

struct Language: Codable {
    let name: String
    let code: String
    
    static let list = [
        Language(name: "Francais", code: "fr"),
        Language(name: "Anglais", code: "En"),
        Language(name: "Albanais", code: "sq"),
        Language(name: "Afrikaans", code: "af"),
        Language(name: "Amharique", code: "am"),
        Language(name: "Arabe", code: "ar"),
        Language(name: "Arménien", code: "hy"),
        Language(name: "Azéri", code: "az"),
        Language(name: "Basque", code: "eu"),
        Language(name: "Biélorusse", code: "be"),
        Language(name: "Bengali", code: "bn"),
        Language(name: "Bosnien", code: "bn"),
        Language(name: "Bulgare", code: "bg"),
        Language(name: "Catalan", code: "ca"),
        Language(name: "Cebuano", code: "ceb"),
        Language(name: "Chinois(simplifié)", code: "zh-CN")
    ]
    
  /*
    var langueCode: [String:String] =
    
    "Chinois(traditionnel)"    "zh-TW"
    "Corse"   "co"
    "Croate"    "hr"
    "Tchèque"    "cs"
    "Danois"    "da"
    "Néerlandais"    "nl"
    "Anglais"    "en"
    "Espéranto"    "eo"
    "Estonien"    "et"
    "Finnois"    "fi"
    "Français"    "fr"
    "Frison"    "fy"
    "Galicien"    "gl"
    "Géorgien"    "ka"
    "Allemand"    "de"
    "Grec"    "el"
    "Gujarati"    "gu"
    "Créole haïtien"    "ht"
    "Haoussa"    "ha"
    "Hawaïen"    "haw" (ISO-639-2)
    "Hébreu"    "he**"
            "Hindi":"hi"
            "Hmong":"hmn" (ISO-639-2)
            "Hongrois":"hu"
            "Islandais":"is"
            "Igbo":"ig"
            "Indonésien":"id"
            "Irlandais":"ga"
            "Italien":"it"
            "Japonais":"ja"
            "Javanais":"jw"
            "Kannada":"kn"
            "Kazakh":"kk"
            "Khmer":"km"
            "Coréen":"ko"
            "Kurde":"ku"
            "Kirghyz":"ky"
            "Laotien":"lo"
            "Latin":"la"
            "Letton":"lv"
            "Lituanien":"lt"
            "Luxembourgeois":"lb"
            "Macédonien":"mk"
            "Malgache":"mg"
            "Malais":"ms"
            "Malayâlam":"ml"
            "Maltais":"mt"
            "Maori":"mi"
            "Marathi":"mr"
            "Mongol":"mn"
            "Birman":"my"
            "Népalais":"ne"
            "Norvégien":"no"
            "Nyanja(Chichewa)":"ny"
            "Pachto":"ps"
            "Perse":"fa"
            "Polonais":"pl"
            "Portugais(Portugal, Brésil)":"pt"
            "Panjabi":"pa"
            "Roumain":"ro"
            "Russe":"ru"
            "Samoan":"sm"
            "Gaélique(Écosse)":"gd"
            "Serbe":"sr"
            "Sesotho":"st"
            "Shona":"sn"
            "Sindhî":"sd"
            "Singhalais":"si"
            "Slovaque":"sk"
            "Slovène":"sl"
            "Somali":"so"
            "Espagnol":"es"
            "Soundanais":"su"
            "Swahili":"sw"
            "Suédois":"sv"
            "Tagalog(philippin)":"tl"
            "Tadjik":"tg"
            "Tamoul":"ta"
            "Télougou":"te"
            "Thaï":"th"
            "Turc":"tr"
            "Ukrainien":"uk"
            "Urdu":"ur"
            "Ouzbek":"uz"
            "Vietnamien":"vi"
            "Gallois":"cy",
            "Xhosa":"xh",
            "Yiddish":"yi",
            "Yoruba";"yo",
            "Zoulou":"zu"]
 */
}
struct TranslationResult: Codable {
    var translatedText: String
    init (translatedText: String) {
        self.translatedText = translatedText
    }
}

