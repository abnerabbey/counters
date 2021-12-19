//
//  CountCell.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import UIKit

class CountCell: UITableViewCell {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let containerView: UIView = create {
        $0.backgroundColor = UIColor(named: "ButtonText")
        $0.layer.cornerRadius = 10
    }
    private let countLabel: UILabel = .withConfig(.init(font: .systemFont(ofSize: 27, weight: .bold), textColor: UIColor(named: "AccentColor")!))
    private let separatorView: UIView = create {
        $0.backgroundColor = UIColor(named: "Background")
    }
    private let titleLabel: UILabel = .withConfig(UILabel.Configuration(font: .systemFont(ofSize: 17, weight: .regular), textColor: UIColor(named: "PrimaryText")!))
    
    private let plusButton: UIButton = UIButton.withConfig(.init(title: "+", font: .systemFont(ofSize: 17, weight: .regular), textColor: UIColor(named: "PrimaryText")!))
    private let minusButton: UIButton = UIButton.withConfig(.init(title: "-", font: .systemFont(ofSize: 17, weight: .regular), textColor: UIColor(named: "PrimaryText")!))
    private lazy var stackButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minusButton, plusButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(named: "Background")
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private var model: Count?
    
    private func setupView() {
        backgroundColor = UIColor(named: "Background")
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(countLabel)
        containerView.addSubview(separatorView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stackButtons)
        
        countLabel.text = "5"
        titleLabel.text = "Cups of coffee"
        countLabel.textAlignment = .right
        plusButton.setTitle("+", for: .normal)
        minusButton.setTitle("-", for: .normal)
        
        containerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
        countLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 8, left: 4, bottom: 0, right: 0), size: CGSize(width: 50, height: 0))
        separatorView.anchor(top: containerView.topAnchor, leading: countLabel.trailingAnchor, trailing: nil, bottom: containerView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: 3, height: 0))
        titleLabel.anchor(top: countLabel.topAnchor, leading: separatorView.trailingAnchor, trailing: containerView.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 6, left: 8, bottom: 0, right: 4))
        stackButtons.anchor(top: nil, leading: nil, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 8), size: CGSize(width: 110, height: 44))
    }
    
    func configure(withModel model: Count) {
        self.model = model
        titleLabel.text = model.title
        countLabel.text = "\(model.count ?? 0)"
    }
    

}
