//
//  Lessons.swift
//  QuestionMemory
//
//  Created by sh3ll on 18.02.2021.
//

import Foundation


struct LessonType {

    enum TYT: String, CaseIterable {
        case Matematik = "Matematik"
        case Turkce = "Türkçe"
        case Fizik = "Fizik"
        case Kimya = "Kimya"
        case Biyoloji = "Biyoloji"
        case Edebiyat = "Edebiyat"
        case Tarih = "Tarih"
        case Cografya = "Coğrafya"
        case Din = "Din Kültürü"
        case Felsefe = "Felsefe"
    }

    enum AYT: String, CaseIterable {
        case Matematik = "Matematik"
        case Fizik = "Fizik"
        case Kimya = "Kimya"
        case Biyoloji = "Biyoloji"
        case Edebiyat = "Edebiyat"
        case Tarih = "Tarih"
        case Cografya = "Coğrafya"
        case Din = "Din Kültürü"
        case Felsefe = "Felsefe"
    }
}
