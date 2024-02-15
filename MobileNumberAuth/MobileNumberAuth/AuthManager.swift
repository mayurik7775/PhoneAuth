//
//  AuthManager.swift
//  MobileNumberAuth
//
//  Created by Admin on 15/02/24.
//
import FirebaseAuth
import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationId: string?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil){[weak self] verificationId , error in
            guard let verificationId = verificationId, error == nil else{
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
        
    }
    public func startAuth(smsCode: String, completion: @escaping (Bool) -> Void){
        
        guard let verificationId = verificationId else{
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential{
        withverificationId: String,
        verificationCode: smsCode
        }
        auth.signIn(with: credential) { result, error in {
            guard result != nil, error == nil else{
                completion(false)
                return
            }
            completion(true)
        }}
    }
}
