//
//  Lacks.swift
//  QuestionMemory
//
//  Created by sh3ll on 18.02.2021.
//

import Foundation


enum LackType: String, CaseIterable {
    case konu = "Konu Eksikliği"
    case bilgi = "Bilgi Eksikliği"
    case bilgi2 = "Bilgiyi Kullanamama"
    case yorum = "Yorum Eksikliği"
    case derin = "Derin Düşünememe"
    case okuma = "Yanlış Okuma"
    case isaret = "Yanlış İşaretleme"
    case dikkat = "Dikkatsizlik"
    case islem = "İşlem Hatası"
}
