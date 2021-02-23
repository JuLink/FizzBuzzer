//
//  FizzBuzzFormViewController.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 22/02/2021.
//

import UIKit

class FizzBuzzFormViewController: UIViewController {
    static let storyboardId = "FizzBuzzFormViewControllerID"

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var int1TextField: UITextField!
    @IBOutlet weak var int2TextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var str1TextField: UITextField!
    @IBOutlet weak var str2TextField: UITextField!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    
    let viewModel: FizzBuzzFormViewModel
    
    private var activeTextField: UITextField?
    
    init?(coder: NSCoder, viewModel: FizzBuzzFormViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with view model.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "FizzBuzz"
        self.navigationController?.tabBarItem.title = "FizzBuzz"
        self.navigationController?.tabBarItem.image = UIImage(systemName: "zzz")

        // Do any additional setup after loading the view.
        self.int1TextField.delegate = self
        self.int2TextField.delegate = self
        self.limitTextField.delegate = self
        self.str1TextField.delegate = self
        self.str2TextField.delegate = self
        
        self.checkButtonVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.unsubscribeFromAllNotifications()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func showFizzBuzz(_ sender: Any) {
        if let parameter = viewModel.fizzbuzzParameter {
            let storyboard = UIStoryboard(name: "FizzBuzzListStoryboard", bundle: nil)
            let listViewModel = FizzBuzzListViewModel(fizzbuzzParameter: parameter)
            let fizzbuzzListVC = storyboard.instantiateViewController(identifier: FizzBuzzListTableViewController.storyboardId) { (coder) -> FizzBuzzListTableViewController? in
                FizzBuzzListTableViewController(coder: coder, viewModel: listViewModel)
            }
            self.viewModel.formValidated()
            self.navigationController?.pushViewController(fizzbuzzListVC, animated: true)
        }
    }
    
    func checkButtonVisibility() {
        self.fizzBuzzButton.isEnabled = self.viewModel.isFormValid
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        if sender == self.int1TextField {
            self.viewModel.int1 = Int(self.int1TextField.text ?? "")
        } else if sender == self.int2TextField {
            self.viewModel.int2 = Int(self.int2TextField.text ?? "")
        } else if sender == self.limitTextField {
            self.viewModel.limit = Int(self.limitTextField.text ?? "")
        } else if sender == self.str1TextField {
            self.viewModel.str1 = self.str1TextField.text
        } else if sender == self.str2TextField {
            self.viewModel.str2 = self.str2TextField.text
        }
        self.checkButtonVisibility()
    }
}

extension FizzBuzzFormViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkButtonVisibility()
    }
}

extension FizzBuzzFormViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWasShown(notification: NSNotification) {
        if let info = notification.userInfo,
           let keyboardSize = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var viewRect = self.view.frame;
            viewRect.size.height -= keyboardSize.height
            
            if let activeField = self.activeTextField,
               !viewRect.contains(activeField.frame.origin) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

}
