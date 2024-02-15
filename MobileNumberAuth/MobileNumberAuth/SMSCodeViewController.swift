//
//  SMSCodeViewController.swift
//  MobileNumberAuth
//
//  Created by Admin on 15/02/24.
//

import UIKit

class SMSCodeViewController: UIViewController {

    
    private let codefield : UITextField = {
        let feild = UITextField()
        feild.backgroundColor = .secondarySystemBackground
        feild.placeholder = "Enter Code"
        feild.returnKeyType = .continue
        feild.textAlignment = .center
        return feild
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(codefield)
        codefield.frame = CGRect(x: 0, y: 0, width: 220, height: 60)
        codefield.center = view.center
        codefield.delegate = self
    }

    func textfeildShouldReturn(_ textfeild: UITextField) -> Bool {
        textfeild.resignFirstResponder()
        
        let number = "+1\(text)"
        if let text = textfeild.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) {[weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = AccountViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
        return true
    }

}
