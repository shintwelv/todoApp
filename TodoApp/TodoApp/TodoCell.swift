//
//  TodoCell.swift
//  TodoApp
//
//  Created by siheo on 11/10/23.
//

import UIKit

class TodoCell: UITableViewCell {
    
    static let identifier = "todoCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAutoLayout() -> Void {
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15)
        ]
        
        let descriptionLabelConstrains: [NSLayoutConstraint] = [
            descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate([
            titleLabelConstraints,
            descriptionLabelConstrains
        ].flatMap{$0})
        
    }
    
}
