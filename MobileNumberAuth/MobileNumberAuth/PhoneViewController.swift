//
//  ViewController.swift
//  MobileNumberAuth
//
//  Created by Admin on 15/02/24.
//

import UIKit

class PhoneViewController: UIViewController {
    
    private let phoneField : UITextField = {
        let feild = UITextField()
        feild.backgroundColor = .secondarySystemBackground
        feild.placeholder = "Phone Number"
        feild.returnKeyType = .continue
        feild.textAlignment = .center
        return feild
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(phoneField)
        phoneField.frame = CGRect(x: 0, y: 0, width: 220, height: 60)
        phoneField.center = view.center
        phoneField.delegate = self
    }

    func textfeildShouldReturn(_ textfeild: UITextField) -> Bool {
        textfeild.resignFirstResponder()
        
        let number = "+1\(text)"
        if let text = textfeild.text, !text.isEmpty {
            AuthManager.shared.startAuth(phoneNumber: number) {[weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = SMSCodeViewController()
                    vc.title = "Enter Code"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        return true
    }
}

