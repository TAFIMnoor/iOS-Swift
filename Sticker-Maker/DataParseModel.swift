//
//  DataParseModel.swift
//  Sticker-Maker
//
//  Created by mohammad noor uddin on 5/7/23.
//

import Foundation

class DataParseModel {
    func getAllCategories() -> [Categories] {
        
        var parsedData: [Categories]?
        
        guard let url = URL(string: " ") else {
            print("Invalid URL")
            return parsedData!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let userName = " "
        let password = " "
        
        request.addValue(userName, forHTTPHeaderField: "UserName")
        request.addValue(password, forHTTPHeaderField: "Password")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0)
            
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error, data == nil {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    
                    let jsonFormattedArray = (jsonArray["data"] as? [[String: Any]])!
                    
                    var tempArray: [Categories] = []
                    
                    for categoryDict in jsonFormattedArray {
                        if let id = categoryDict["id"] as? Int,
                           let name = categoryDict["name"] as? String,
                           let thumb = categoryDict["thumb"] as? String,
                           let thumb_v = categoryDict["thumb_v"] as? String,
                           let thumb_bg_color = categoryDict["thumb_bg_color"] as? String,
                           let number_of_sticker = categoryDict["number_of_sticker"] as? Int,
                           let number_of_item = categoryDict["number_of_item"] as? Int,
                           let text = categoryDict["text"] as? String {
                            
                            let categoryObject = Categories(id: id, name: name, thumb: thumb, thumb_v: thumb_v, thumb_bg_color: thumb_bg_color, text: text, number_of_item: number_of_item, number_of_sticker: number_of_sticker)
                            
                            tempArray.append(categoryObject)
                        }
                    }
                    parsedData = tempArray
                }
            } catch {
                
                print("JSON serialization error: \(error.localizedDescription)")
                
            }
            
            semaphore.signal()
    
        }.resume()
        
        semaphore.wait()
        
        return parsedData!
    }
}


extension DataParseModel {
    func getEachCategoryById(with categoryId: String, with encodedLoginString: String) -> CategoryById {
        
        var finalParsedData: CategoryById?
        
        guard let url = URL(string: "http://api.dev.sticker-maker.com/item/category/\(categoryId)") else {
            print("Invalid URL")
            return finalParsedData!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(encodedLoginString, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let error, data == nil {
                print(error.localizedDescription)
                return
            }
            
            do
            {
                if let parsedData = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    
                    let categoryId = parsedData["categoryId"] as? String
                    let categoryName = parsedData["categoryName"] as? String
                    let version = parsedData["version"] as? String
                    let number_Of_Sticker = parsedData["number_Of_Sticker"] as? String
                    let number_Of_Item = parsedData["number_Of_Item"] as? String
                    let items = (parsedData["items"] as? [[String: Any]])!
                    
                    finalParsedData = CategoryById(categoryId: categoryId!, categoryName: categoryName!, version: version!, number_Of_Sticker: number_Of_Sticker!, number_Of_Item: number_Of_Item!, items: [])
                    
                    for item in items {
                         if let name = item["name"] as? String,
                            let code = item["code"] as? String,
                            let thumb = item["thumb"] as? String,
                            let thumbBgColor = item["thumbBgColor"] as? String,
                            let author = item["author"] as? String,
                            let isPremium = item["isPremium"] as? String,
                            let isAnimated = item["isAnimated"] as? String,
                            let telegram_url = item["telegram_url"] as? String,
                            let totalStickers = item["totalStickers"] as? String,
                            let version = item["version"] as? String,
                            let stickers = item["stickers"] as? [String] {
                             
                             let itemObject = Items(name: name, code: code, thumb: thumb, thumbBgColor: thumbBgColor, author: author, isPremium: isPremium, isAnimated: isAnimated, telegram_url: telegram_url, totalStickers: totalStickers, version: version, stickers: stickers)
                             
                             finalParsedData?.items.append(itemObject)
                         }
                    }
                }
            }
            catch
            {
                print("Could not process data")
            }
        }
        
        return finalParsedData!
    }
}
