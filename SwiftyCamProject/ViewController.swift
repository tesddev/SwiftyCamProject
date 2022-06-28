//
//  ViewController.swift
//  SwiftyCamProject
//
//  Created by GIGL iOS on 27/06/2022.
//

import UIKit
import SwiftyCam

class ViewController: SwiftyCamViewController {

//    let captureButton = SwiftyCamButton(frame: buttonFrame)
//    captureButton.delegate = self
    
    private let takePhotoButton: SwiftyCamButton = {
        let snap = SwiftyCamButton()
        snap.setTitle("Take Photo", for: .normal)
        snap.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        snap.translatesAutoresizingMaskIntoConstraints = false
        snap.clipsToBounds = true
        snap.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        snap.layer.cornerRadius = 20
        snap.heightAnchor.constraint(equalToConstant: 42).isActive = true
        snap.layer.borderWidth = 1
        snap.backgroundColor = .gray
        snap.layer.borderColor = UIColor.gray.cgColor
        return snap
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        takePhotoButton.delegate = self
        setupConstraints()
        defaultCamera = .front
    }
    
    private func setupConstraints() {
        view.addSubview(takePhotoButton)
        
        NSLayoutConstraint.activate([
            
            takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 233),
        ])
    }

    
    @objc func didTapTakePhoto() {
        print("Take Photo")
        takePhoto()
    }
}

