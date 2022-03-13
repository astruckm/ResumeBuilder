//
//  BasicInfoViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit
import PhotosUI

class BasicInfoViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    let viewModel = BasicInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Basic Info"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .done, target: self, action: #selector(saveButtonTapped))
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(photoContainerTapped))
        photoContainerView.addGestureRecognizer(photoTap)
    }

    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func photoContainerTapped() {
        let alert = UIAlertController(title: nil, message: "Add Photo", preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
            self?.presentCamera()
        }
        let choosePhotoAction = UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.pickPhoto()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(takePhotoAction)
        alert.addAction(choosePhotoAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func pickPhoto() {
        var pickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        pickerConfig.filter = .images
        let pickerVC = PHPickerViewController(configuration: pickerConfig)
        pickerVC.delegate = self
        self.present(pickerVC, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension BasicInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.assign(text: textField.text ?? "", from: textField.tag)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.assign(text: textField.text ?? "", from: textField.tag)
        textField.resignFirstResponder()
    }
}

extension BasicInfoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else { return }
        viewModel.photo = image
        DispatchQueue.main.async {
            self.photoImageView.image = image
        }
    }
}

extension BasicInfoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let image = reading as? UIImage else { return }
            self.viewModel.photo = image
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
        
    }
    
    
}
