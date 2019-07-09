//
//  Translate.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct TranslationData: Codable {
    var data: Translations
}

struct Translations: Codable {
    var translations: [Translation]
}

struct Translation: Codable {
    var translatedText: String
}

struct Language: Codable {
    let name: String
    let code: String
    
    static var list = [
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
        Language(name: "Chinois(simplifié)", code: "zh-CN"),
        Language(name: "Chinois(traditionnel)", code: "zh-TW"),
        Language(name: "Corse", code: "co"),
        Language(name: "Croate", code: "hr"),
        Language(name: "Tchèque", code: "cs"),
        Language(name: "Danois", code: "da"),
        Language(name: "Néerlandais", code: "nl"),
        Language(name: "Espéranto", code: "eo"),
        Language(name: "Estonien", code: "et"),
        Language(name: "Finnois", code: "fi"),
        Language(name: "Espéranto", code: "eo"),
        Language(name: "Estonien", code: "et"),
        Language(name: "Kannada", code: "kn"),
        Language(name: "Tamoul", code: "ta"),
        Language(name: "Maltais", code: "mt"),
        Language(name: "Marathi", code: "mr"),
        Language(name: "Yoruba", code: "yo"),Language(name: "Gallois", code: "cy"),
        Language(name: "Hindi", code: "hi"),
        Language(name: "Malais", code: "ms"),
        Language(name: "Sindhî", code: "sd"),
        Language(name: "Suédois", code: "sv"),
        Language(name: "Latin", code: "la"),
        Language(name: "Malgache", code: "mg"),
        Language(name: "Polonais", code: "pl"),
        Language(name: "Kirghyz", code: "ky"),
        Language(name: "Hmong", code: "hmn"),
        Language(name: "Soundanais", code: "su"),
        Language(name: "Kazakh", code: "kk"),
        Language(name: "Macédonien", code: "mk"),
        Language(name: "Slovène", code: "sl"),
        Language(name: "Télougou", code: "te"),
        Language(name: "Perse", code: "fa"),
        Language(name: "Gaélique(Écosse)", code: "gd"),
        Language(name: "Zoulou", code: "zu"),
        Language(name: "Sesotho", code: "st"),
        Language(name: "Roumain", code: "ro"),
        Language(name: "Samoan", code: "sm"),
        Language(name: "Thaï", code: "th"),
        Language(name: "Japonais", code: "ja"),
        Language(name: "Maori", code: "mi"),
        Language(name: "Tagalog(philippin)", code: "tl"),
        Language(name: "Xhosa", code: "xh"),
        Language(name: "Birman", code: "my"),
        Language(name: "Pachto", code: "ps"),
        Language(name: "Ouzbek", code: "uz"),
        Language(name: "Igbo", code: "ig"),
        Language(name: "Kurde", code: "ku"),
        Language(name: "Serbe", code: "sr"),
        Language(name: "Lituanien", code: "lt"),
        Language(name: "Norvégien", code: "no"),
        Language(name: "Shona", code: "sn"),
        Language(name: "Swahili", code: "sw"),
        Language(name: "Yiddish", code: "yi"),
        Language(name: "Luxembourgeois", code: "lb"),
        Language(name: "Malayâlam", code: "ml"),
        Language(name: "Vietnamien", code: "vi"),
        Language(name: "Slovaque", code: "sk"),
        Language(name: "Letton", code: "lv"),
        Language(name: "Nyanja(Chichewa)", code: "ny"),
        Language(name: "Espagnol", code: "es"),
        Language(name: "Turc", code: "tr"),
        Language(name: "Indonésien", code: "id"),
        Language(name: "Coréen", code: "ko"),
        Language(name: "Portugais(Portugal, Brésil)", code: "pt"),
        Language(name: "Javanais", code: "jw"),
        Language(name: "Ukrainien", code: "uk"),
        Language(name: "Irlandais", code: "ga"),
        Language(name: "Mongol", code: "mn"),
        Language(name: "Islandais", code: "is"),
        Language(name: "Russe", code: "ru"),
        Language(name: "Somali", code: "so"),
        Language(name: "Khmer", code: "km"),
        Language(name: "Singhalais", code: "si"),
        Language(name: "Hongrois", code: "hu"),
        Language(name: "Laotien", code: "lo"),
        Language(name: "Panjabi", code: "pa"),
        Language(name: "Tadjik", code: "tg"),
        Language(name: "Italien", code: "it"),
        Language(name: "Népalais", code: "ne"),
        Language(name: "Urdu", code: "ur")
    ]
}

 



