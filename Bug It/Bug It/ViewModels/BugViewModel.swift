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

    func uploadBugData(completion: @escaping (Bool) -> Void) {
        // Implement data upload logic here (Google Sheets, Notion, etc.)
        // Call completion handler with success status
        completion(true)
    }
}

