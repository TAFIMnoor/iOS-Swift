//
//  Model.swift
//  Sticker-Maker
//
//  Created by mohammad noor uddin on 4/7/23.
//

import Foundation


struct ResponseData: Codable {
    let status: Int
    let message: String
    let data: [Categories]
}

struct Categories: Codable {
    let id: Int
    let name: String
    let thumb: String
    let thumb_v: String
    let thumb_bg_color: String
    let text: String
    let number_of_item: Int
    let number_of_sticker: Int
    
    init(id: Int, name: String, thumb: String, thumb_v: String, thumb_bg_color: String, text: String, number_of_item: Int, number_of_sticker: Int) {
        self.id = id
        self.name = name
        self.thumb = thumb
        self.thumb_v = thumb_v
        self.thumb_bg_color = thumb_bg_color
        self.text = text
        self.number_of_item = number_of_item
        self.number_of_sticker = number_of_sticker
    }
}

struct CategoryById: Codable {
    var categoryId: String
    var categoryName: String
    var version: String
    var number_Of_Sticker: String
    var number_Of_Item: String
    var items: [Items]
    
    init(categoryId: String, categoryName: String, version: String, number_Of_Sticker: String, number_Of_Item: String, items: [Items]) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.version = version
        self.number_Of_Sticker = number_Of_Sticker
        self.number_Of_Item = number_Of_Item
        self.items = items
    }
}

struct Items: Codable {
    var name: String
    var code: String
    var thumb: String
    var thumbBgColor: String
    var author: String
    var isPremium: String
    var isAnimated: String
    var telegram_url: String
    var totalStickers: String
    var version: String
    var stickers: [String]
    
    init(name: String, code: String, thumb: String, thumbBgColor: String, author: String, isPremium: String, isAnimated: String, telegram_url: String, totalStickers: String, version: String, stickers: [String]) {
        self.name = name
        self.code = code
        self.thumb = thumb
        self.thumbBgColor = thumbBgColor
        self.author = author
        self.isPremium = isPremium
        self.isAnimated = isAnimated
        self.telegram_url = telegram_url
        self.totalStickers = totalStickers
        self.version = version
        self.stickers = stickers
    }
}
