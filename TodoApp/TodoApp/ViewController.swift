//
//  ViewController.swift
//  TodoApp
//
//  Created by siheo on 11/10/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let todoListTableView: UITableView = {
        let tb = UITableView()
        tb.estimatedRowHeight = 50
        return tb
    }()
    
    private var todoList: [(String, String)] = [
        ("강아지 밥주기","100원 짜리 사료사용해서\n아침 8시에 칼 같이 일어나\n씻기도 전에 밥부터 줘야 함"),
        ("고양이 밥주기","200원 짜리 사료사용"),
        ("사슴벌레 밥주기","300원 짜리 사료사용"),
        ("토끼 밥주기","400원 짜리 사료사용"),
    ]
    
    private var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAutoLayout()
    }
    
    private func configureUI() -> Void {
        self.view.backgroundColor = .white
        self.title = "할 일"
        
        let createButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonTapped))
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = createButton
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        todoListTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        
        [todoListTableView].forEach{self.view.addSubview($0)}
    }
    
    private func configureAutoLayout() -> Void {
        todoListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let todoListTableViewConstraints: [NSLayoutConstraint] = [
            todoListTableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
            todoListTableView.leftAnchor.constraint(equalTo: self.safeArea.leftAnchor),
            todoListTableView.rightAnchor.constraint(equalTo: self.safeArea.rightAnchor),
            todoListTableView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate([
            todoListTableViewConstraints
        ].flatMap{$0})
    }
    
    @objc private func createButtonTapped(_ button:UIBarButtonItem) {
        let vc: EditViewController = EditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier) as? TodoCell else {return UITableViewCell()}
        
        cell.titleLabel.text = todoList[indexPath.row].0
        cell.descriptionLabel.text = todoList[indexPath.row].1
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: EditViewController = EditViewController()
        vc.configureData(todoList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
