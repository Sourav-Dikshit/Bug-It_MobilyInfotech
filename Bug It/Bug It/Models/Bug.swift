//
//  Bug.swift
//  Bug It
//
//  Created by Sourav Dikshit on 04/02/24.
//

import UIKit

struct Bug {
    var timestamp: Date
    var screenshot: UIImage?
    var description: String
    var imageURL: URL?
    
    
    var sheetTabName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        
        return formatter.string(from: timestamp)
    }
    
}
