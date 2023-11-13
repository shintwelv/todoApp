//
//  EditViewController.swift
//  TodoApp
//
//  Created by siheo on 11/10/23.
//

import UIKit
import CoreData

enum ViewTag: Int {
    case titleTextView = 100
    case descriptionTextView = 101
}

final class EditViewController: UIViewController {
    
    private var container: NSPersistentContainer!
    
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
    
    private var todo:Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
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
        
        if let _ = todo {
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
        
        if let _ = todo {
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
    
    
    func configureData(_ todo:Todo) -> Void {
        self.todo = todo
        self.titleTextView.text = todo.title
        self.descriptionTextView.text = todo.detail
    }
    
    @objc private func createButtonTapped(_ button: UIButton) {
        let title: String = titleTextView.text
        let detail: String = descriptionTextView.text
        
        let context: NSManagedObjectContext = self.container.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Todo", in: context)!
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(title, forKey: "title")
        managedObject.setValue(detail, forKey: "detail")
        
        saveContext(context) { error in
            if let error = error {
                print("failed to create todo = \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func updateButtonTapped(_ button: UIButton) {
        let context: NSManagedObjectContext = self.container.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Todo")
        fetchRequest.predicate = NSPredicate(format: "title == %@ && detail == %@", todo!.title!, todo!.detail!)
        
        do {
            let title: String = titleTextView.text
            let detail: String = descriptionTextView.text
            
            let result = try context.fetch(fetchRequest)
            let managedObject = result[0] as! NSManagedObject
            managedObject.setValue(title, forKey: "title")
            managedObject.setValue(detail, forKey: "detail")
            
            saveContext(context) { error in
                if let error = error {
                    print("failed to update todo item = \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("failed to update todo item = \(error.localizedDescription)")
        }
    }
    
    @objc private func deleteButtonTapped(_ button: UIButton) {
        let context: NSManagedObjectContext = self.container.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Todo")
        fetchRequest.predicate = NSPredicate(format: "title == %@ && detail == %@", todo!.title!, todo!.detail!)
        
        do {
            let result = try context.fetch(fetchRequest)
            let managedObject = result[0] as! NSManagedObject
            context.delete(managedObject)
            
            saveContext(context) { error in
                if let error = error {
                    print("failed to delete todo item = \(error.localizedDescription)")
                } else {
                    let alertController = UIAlertController(title: "주의", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true)
                }
            }
        } catch {
            print("failed to delete todo item = \(error.localizedDescription)")
        }
    }
    
    private func saveContext(_ context:NSManagedObjectContext, completionHander:((NSError?) -> ())?) -> Void {
        do {
            try context.save()
            if let completionHander = completionHander {
                completionHander(nil)
            }
        } catch {
            if let completionHander = completionHander {
                completionHander(error as NSError?)
            }
        }
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
