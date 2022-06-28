//
//  CameraManagerViewController.swift
//  SwiftyCamProject
//
//  Created by Tes on 28/06/2022.
//

import UIKit
import CameraManager

class CameraManagerViewController: UIViewController {

    let cameraManager = CameraManager()
    var takenImage = UIImage()
    
    let backButton: UIButton = {
      let button = UIButton()
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(named: "house"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = .black
      return button
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 1/3
        progressView.progressViewStyle = .default
        progressView.setProgress(0.5, animated: true)
        progressView.trackTintColor = .gray.withAlphaComponent(0.2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .green
        return progressView
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Step 1"
        return label
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the header"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let captureInstructionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "This is the instruction"
        textView.isEditable = false
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .systemGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .white
        return textView
    }()
    
    lazy var poweredByImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect())
        imageView.image = UIImage(named: "poweredByVeriFind")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let takePhotoButton: UIButton = {
        let snap = UIButton()
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
    
    let captureView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        cameraManager.addPreviewLayerToView(self.captureView)
        cameraManager.cameraDevice = .front
    }
    
    private func setupConstraints() {
        view.addSubview(takePhotoButton)
        view.addSubview(poweredByImageView)
        view.addSubview(backButton)
        view.addSubview(progressView)
        view.addSubview(stepLabel)
        view.addSubview(headerLabel)
        view.addSubview(captureInstructionTextView)
        view.addSubview(captureView)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            progressView.heightAnchor.constraint(equalToConstant: 3),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: backButton.centerYAnchor, constant: -2),
            
            stepLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            stepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 30),
            headerLabel.widthAnchor.constraint(equalToConstant: 270),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            captureInstructionTextView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            captureInstructionTextView.widthAnchor.constraint(equalToConstant: 276),
            captureInstructionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureInstructionTextView.heightAnchor.constraint(equalToConstant: 66),
            
            captureView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            captureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureView.widthAnchor.constraint(equalToConstant: 300),
            captureView.heightAnchor.constraint(equalToConstant: 300),
            
            takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePhotoButton.topAnchor.constraint(equalTo: captureView.bottomAnchor, constant: 30),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 233),
            
            poweredByImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            poweredByImageView.heightAnchor.constraint(equalToConstant: 22),
            poweredByImageView.widthAnchor.constraint(equalToConstant: 117),
            poweredByImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }


    
    @objc func didTapTakePhoto() {
        print("Take Photo")
        
        cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                    print("unable to take picture")
                case .success(let content):
                    self.takenImage = content.asImage ?? UIImage()
                print("Here is the taken image ``````\(self.takenImage)")
            }
        })
    }
        
    @objc func backButtonPressed() {
        print("Back pressed")
    }

}
