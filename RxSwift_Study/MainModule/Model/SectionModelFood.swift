//
//  SectionModelFood.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import Foundation
import RxSwift
import RxDataSources

class SectionModelFood {
    
    let foods = Observable.just([
        SectionModel(model: "K",
                     items: [Food(name: "Колбаски", flickrID: "1")]),
        SectionModel(model: "Б",
                     items: [Food(name: "Блинчики", flickrID: "2"),
                             Food(name: "Бекон", flickrID: "8")]),
        SectionModel(model: "С",
                     items: [Food(name: "Суши", flickrID: "3"),                           Food(name: "Салат", flickrID: "7"),
                             Food(name: "Сыр", flickrID: "19")]),
        SectionModel(model: "П",
                     items: [Food(name: "Пицца", flickrID: "4")]),
        
        SectionModel(model: "Г",
                     items: [Food(name: "Гамбургеры", flickrID: "5"),
                             Food(name: "Греческий салат", flickrID: "11")]),
        SectionModel(model: "Я",
                     items: [Food(name: "Ягоды", flickrID: "6"),
                             Food(name: "Я не знаю что это", flickrID: "17")]),
        SectionModel(model: "Н",
                     items: [Food(name: "Нарезка", flickrID: "9")]),
        SectionModel(model: "З",
                     items: [Food(name: "Зеленый салат", flickrID: "10"),
                             Food(name: "Завтрак", flickrID: "15")]),
        SectionModel(model: "Ф",
                     items: [Food(name: "Фастфуд", flickrID: "12"),
                             Food(name: "Фастфуд 2", flickrID: "13")]),
        SectionModel(model: "Д", items: [Food(name: "Десерт", flickrID: "14")]),
        SectionModel(model: "М", items: [Food(name: "Мюсли", flickrID: "16")]),
        SectionModel(model: "В", items: [Food(name: "Виноград", flickrID: "18")]),
        SectionModel(model: "Е", items: [Food(name: "Еще блинчики", flickrID: "20")])
    ])
}
