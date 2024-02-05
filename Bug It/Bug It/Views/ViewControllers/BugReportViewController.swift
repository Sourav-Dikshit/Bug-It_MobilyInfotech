//
//  BugReportViewController.swift
//  Bug It
//
//  Created by Sourav Dikshit on 04/02/24.
//

import UIKit

class BugReportViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var bugImageView: UIImageView!
    @IBOutlet var bugDescriptionTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    var bugViewModel = BugViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        hideAllViews()
        
    }
    
    // MARK: - UISetup
    func setupUI() {
        title = "Let's Report The Bug"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        
    }
    
    
    
    func hideAllViews() {
        bugImageView.isHidden = true
        bugDescriptionTextView.isHidden = true
        submitButton.isHidden = true
    }
    
    func showAllViews() {
        bugDescriptionTextView.isHidden = false
        bugImageView.isHidden = false
        submitButton.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        // Display an action sheet with options
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let fromGalleryAction = UIAlertAction(title: "From Gallery", style: .default) { [weak self] _ in
            self?.openGalleryClicked()
        }
        actionSheet.addAction(fromGalleryAction)
        
        let takeScreenshotAction = UIAlertAction(title: "Take Screenshot", style: .default) { [weak self] _ in
            self?.captureScreenshotClicked()
        }
        actionSheet.addAction(takeScreenshotAction)
        
     
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func openGalleryClicked() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func captureScreenshotClicked() {
        if let screenshot = captureScreenshot() {
            bugImageView.image = screenshot
            bugViewModel.bugImage = screenshot
            
            showAllViews()
            
        }
    }
    
    @IBAction func submitBugReport(_ sender: Any) {
        bugViewModel.bugDescription = bugDescriptionTextView.text
        bugViewModel.uploadBugData { [weak self] success in
            if success {
                // Handle successful bug report
                print("Bug report successful!")
                
                self?.hideAllViews()
                
                // Display a success message or handle errors accordingly
                let alertController = UIAlertController(title: "Bug Submitted", message: "Thank you for reporting the bug!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                }
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
                
            } else {
                // Handle failed bug report
                print("Failed to report bug.")
            }
        }
    }
    
    // MARK: - Helper
    
    func captureScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        return screenshot
    }
    
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            showAllViews()
            
            bugViewModel.bugImage = selectedImage
            bugImageView.image = selectedImage
            
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
