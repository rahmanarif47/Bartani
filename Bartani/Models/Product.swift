//
//  Product.swift
//  Bartani
//
//  Created by Rahman Fadhil on 22/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import CloudKit

struct Product {
    var title: String
    var price: Int
    var quantity: String
    var description: String
    var image: UIImage?
    
    static func fromRecords(data: [CKRecord]) -> [Product] {
        var products = [Product]()
        
        for record in data {
            if let image = record.value(forKey: "image") as? CKAsset, let url = image.fileURL, let data = NSData(contentsOf: url) {
                products.append(Product(
                    title: record.value(forKey: "title") as? String ?? "",
                    price: record.value(forKey: "price") as? Int ?? 0,
                    quantity: record.value(forKey: "quantity") as? String ?? "",
                    description: record.value(forKey: "description") as? String ?? "",
                    image: UIImage(data: data as Data)
                ))
            }
        }
        
        return products
    }
}
