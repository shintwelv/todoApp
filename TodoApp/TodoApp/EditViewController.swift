//
//  EditViewController.swift
//  TodoApp
//
//  Created by siheo on 11/10/23.
//

import UIKit

enum ViewTag: Int {
    case titleTextView = 100
    case descriptionTextView = 101
}

final class EditViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let titleTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16, weight: .regular)
        tv.textColor = .black
        tv.keyboardType = .default
        tv.returnKeyType = .default
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.textAlignment = .left
        tv.backgroundColor = .systemGray6
        tv.tag = ViewTag.titleTextView.rawValue
        return tv
    }()
    
    private let descripionLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16, weight: .regular)
        tv.textColor = .black
        tv.keyboardType = .default
        tv.returnKeyType = .default
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.textAlignment = .left
        tv.backgroundColor = .systemGray6
        tv.tag = ViewTag.descriptionTextView.rawValue
        return tv
    }()
    
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("생성", for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정", for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    private var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    private var todo:(String, String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAutoLayout()
    }
    
    private func configureUI() -> Void {
        self.view.backgroundColor = .white
        
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        [
            titleLabel,
            titleTextView,
            descripionLabel,
            descriptionTextView,
        ].forEach{
            self.view.addSubview($0)
        }
        
        if let todo = todo {
            [
                updateButton,
                deleteButton
            ].forEach{
                self.view.addSubview($0)
            }
        } else {
            [
                createButton
            ].forEach{
                self.view.addSubview($0)
            }
        }
    }
    
    private func configureAutoLayout() -> Void {
        [titleLabel, 
         titleTextView,
         descripionLabel,
         descriptionTextView,
         updateButton,
         deleteButton,
         createButton
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let titleLabeLConstraints:[NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.safeArea.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.safeArea.rightAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let titleTextViewConstraints: [NSLayoutConstraint] = [
            titleTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            titleTextView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1.0),
            titleTextView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            titleTextView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let descriptionLabelConstraints: [NSLayoutConstraint] = [
            descripionLabel.topAnchor.constraint(equalTo: self.titleTextView.bottomAnchor, constant: 15),
            descripionLabel.widthAnchor.constraint(equalTo: titleTextView.widthAnchor, multiplier: 1.0),
            descripionLabel.leftAnchor.constraint(equalTo: titleTextView.leftAnchor),
            descripionLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let descriptionTextViewConstraints: [NSLayoutConstraint] = [
            descriptionTextView.topAnchor.constraint(equalTo: descripionLabel.bottomAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: descripionLabel.widthAnchor, multiplier: 1.0),
            descriptionTextView.leftAnchor.constraint(equalTo: descripionLabel.leftAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant:100)
        ]
        
        let createButtonConstraints: [NSLayoutConstraint] = [
            createButton.widthAnchor.constraint(equalToConstant: 40),
            createButton.heightAnchor.constraint(equalToConstant: 30),
            createButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            createButton.rightAnchor.constraint(equalTo: descriptionTextView.rightAnchor),
        ]
        
        let updateButtonConstraints: [NSLayoutConstraint] = [
            updateButton.widthAnchor.constraint(equalToConstant: 40),
            updateButton.heightAnchor.constraint(equalToConstant: 30),
            updateButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            updateButton.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -15)
        ]
        
        let deleteButtonConstraints: [NSLayoutConstraint] = [
            deleteButton.widthAnchor.constraint(equalTo: updateButton.widthAnchor, multiplier: 1.0),
            deleteButton.heightAnchor.constraint(equalTo: updateButton.heightAnchor, multiplier: 1.0),
            deleteButton.topAnchor.constraint(equalTo: updateButton.topAnchor),
            deleteButton.rightAnchor.constraint(equalTo: descriptionTextView.rightAnchor),
        ]
        
        NSLayoutConstraint.activate([
            titleLabeLConstraints,
            titleTextViewConstraints,
            descriptionLabelConstraints,
            descriptionTextViewConstraints,
        ].flatMap{$0})
        
        if let todo = todo {
            NSLayoutConstraint.activate([
                updateButtonConstraints,
                deleteButtonConstraints
            ].flatMap{$0})
        } else {
            NSLayoutConstraint.activate([
                createButtonConstraints
            ].flatMap{$0})
        }
    }
    
    
    func configureData(_ todo:(String, String)) -> Void {
        self.todo = todo
        self.titleTextView.text = todo.0
        self.descriptionTextView.text = todo.1
    }
    
    @objc private func createButtonTapped(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateButtonTapped(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteButtonTapped(_ button: UIButton) {
        let alertController = UIAlertController(title: "주의", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}

extension EditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.tag == ViewTag.titleTextView.rawValue {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
        }
        
        return true
    }
    
}
