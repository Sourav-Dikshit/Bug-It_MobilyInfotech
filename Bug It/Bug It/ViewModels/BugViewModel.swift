//
//  BugViewModel.swift
//  Bug It
//
//  Created by Sourav Dikshit on 04/02/24.
//

import UIKit


class BugViewModel {
    
    
    var bugImage: UIImage?
    var bugDescription: String?
    
    private let googleSheetsUploader: GoogleSheetsUploader
    
    init(googleSheetsUploader: GoogleSheetsUploader = GoogleSheetsUploader.shared) {
        self.googleSheetsUploader = googleSheetsUploader
    }
    
    func uploadBugData(completion: @escaping (Bool) -> Void) {
        
        
        let bug = Bug(timestamp: Date(), screenshot: bugImage, description: bugDescription ?? "", imageURL: URL(string: "https://example.com/path/to/image.jpg"))
        
        googleSheetsUploader.uploadBugData(bug: bug) { success in
            completion(success)
        }
    }
}


