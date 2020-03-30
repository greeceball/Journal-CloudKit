//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Colby Harris on 3/30/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var bodyTextFieldView: UITextView!
    
    var entry: Entry? {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.updateViews()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        entryTitleTextField.delegate = self
    }
    
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        entryTitleTextField.text = ""
        bodyTextFieldView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = entryTitleTextField.text, !title.isEmpty,
            let body = bodyTextFieldView.text, !body.isEmpty
            else { return }
        
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        entryTitleTextField.text = entry.title
        bodyTextFieldView.text = entry.body
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        entryTitleTextField.resignFirstResponder()
        return true
    }
}
