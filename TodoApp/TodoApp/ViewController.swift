//
//  ViewController.swift
//  TodoApp
//
//  Created by siheo on 11/10/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "할 일"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .systemGray5
        return label
    }()
    
    private let todoListTableView: UITableView = {
        let tb = UITableView()
        tb.estimatedRowHeight = 50
        return tb
    }()
    
    private var todoList: [(String, String)] = [
        ("강아지 밥주기","100원 짜리 사료사용해서 아침 8시에 칼 같이 일어나 씻기도 전에 밥부터 줘야 함"),
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
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        todoListTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        
        [titleLabel, todoListTableView].forEach{self.view.addSubview($0)}
    }
    
    private func configureAutoLayout() -> Void {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.safeArea.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.safeArea.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let todoListTableViewConstraints: [NSLayoutConstraint] = [
            todoListTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            todoListTableView.leftAnchor.constraint(equalTo: self.safeArea.leftAnchor),
            todoListTableView.rightAnchor.constraint(equalTo: self.safeArea.rightAnchor),
            todoListTableView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate([
            titleLabelConstraints,
            todoListTableViewConstraints
        ].flatMap{$0})
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
    
}
