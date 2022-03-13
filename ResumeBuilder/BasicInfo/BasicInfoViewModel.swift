//
//  BasicInfoViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class BasicInfoViewModel {
    var name: String?
    var address: String?
    var phoneNumber: String?
    var email: String?
    var photo: UIImage?
    var reloadUI: (() -> Void)?
        
    func assign(text: String, from tag: Int) {
        switch tag {
        case 1: name = text
        case 2: address = text
        case 3: phoneNumber = text
        case 4: email = text
        default: break
        }
    }
    
    func saveData() {
        UserDefaults.standard.set(name, forKey: DefaultsKeys.name)
        UserDefaults.standard.set(address, forKey: DefaultsKeys.address)
        UserDefaults.standard.set(phoneNumber, forKey: DefaultsKeys.phoneNumber)
        UserDefaults.standard.set(email, forKey: DefaultsKeys.email)
        if let photoData = photo?.pngData() {
            UserDefaults.standard.set(photoData, forKey: DefaultsKeys.photo)
        }
    }
    
    func loadData() {
        name = UserDefaults.standard.string(forKey: DefaultsKeys.name)
        address = UserDefaults.standard.string(forKey: DefaultsKeys.address)
        phoneNumber = UserDefaults.standard.string(forKey: DefaultsKeys.phoneNumber)
        email = UserDefaults.standard.string(forKey: DefaultsKeys.email)
        if let photoData = UserDefaults.standard.data(forKey: DefaultsKeys.photo) {
            photo = UIImage(data: photoData)
        }
        reloadUI?()
    }
    
}
