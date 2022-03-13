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
    
    func assign(text: String, from tag: Int) {
        switch tag {
        case 1: name = text
        case 2: address = text
        case 3: phoneNumber = text
        case 4: email = text
        default: break
        }
    }
}
