//
//  LoginViewController.swift
//  Bug It
//
//  Created by Sourav Dikshit on 05/02/24.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            if let error = error {
                // Handle error if sign-in fails
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // User is signed in successfully
            guard let idToken = user?.user.idToken,
                  let accessToken = user?.user.accessToken else {
                // Handle case when authentication data is missing
                print("Google Sign-In failed: No authentication data")
                return
            }
            
            // Ask for additional scope permision
            
            guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
                return
            }
            
            let sheetScope = "https://www.googleapis.com/auth/spreadsheets"
            let grantedScopes = currentUser.grantedScopes
            if grantedScopes == nil || !grantedScopes!.contains(sheetScope) {
              // Request additional sheet scope.
                let additionalScopes = [sheetScope]
                

                currentUser.addScopes(additionalScopes, presenting: self) { signInResult, error in
                    guard error == nil else { return }
                    guard let signInResult = signInResult else { return }

                    // Check if the user granted access to the scopes you requested.
                }

                
            }
            
            
            
            
            
            
            
            
            
            // Move to BugReport Screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let bugReportVC = storyboard.instantiateViewController(withIdentifier: "BugReportVC") as? BugReportViewController {
                        self.navigationController!.pushViewController(bugReportVC, animated: true)
                    }
            }
    }
    
    
    
    @IBAction func signOut(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signOut()
    }
}
