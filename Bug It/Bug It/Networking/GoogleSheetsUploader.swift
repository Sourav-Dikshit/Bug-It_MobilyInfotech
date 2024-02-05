import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

class GoogleSheetsUploader {
    
    static let shared = GoogleSheetsUploader()
    
    private var service = GTLRSheetsService()
    
    private init() {}
    
    func uploadBugData(bug: Bug, completion: @escaping (Bool) -> Void) {
        let spreadsheetId = "1zuypJh7J3mEvjqMxnkAh3Rm3q-hRl5SNd8plc_1t5EE"
        let sheetName = bug.sheetTabName
        
        let values: [[Any]] = [
            [bug.timestamp.description, bug.description,  bug.imageURL?.absoluteString ?? ""]
        ]
        
        let range = "A:C"
        
        let valueRange = GTLRSheets_ValueRange()
        valueRange.values = values
        
        
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
            return
        }
        
        
        print(currentUser.grantedScopes)
        
        currentUser.refreshTokensIfNeeded { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            let query = GTLRSheetsQuery_SpreadsheetsValuesAppend.query(withObject: valueRange, spreadsheetId: spreadsheetId, range: range)
            query.valueInputOption = "RAW"
            
            
            // Set the authorization header
            query.additionalHTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
            
            
            self.service.executeQuery(query) { _, _, error in
                let success = error == nil
                completion(success)
            }
        }
    }
}
