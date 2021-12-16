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
        
    }
    private let countLabel: UILabel = .withConfig(.init(font: .systemFont(ofSize: 25, weight: .bold), textColor: UIColor(named: "AccentColor")!))
    private let separatorView: UIView = create {
        $0.backgroundColor = UIColor(named: "Background")
    }
    private let titleLabel: UILabel = .withConfig(UILabel.Configuration(font: .systemFont(ofSize: 17, weight: .regular), textColor: UIColor(named: "PrimaryText")!))
    private let segmentedControl: UISegmentedControl = UISegmentedControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(countLabel)
        containerView.addSubview(separatorView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(segmentedControl)
        
        containerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        countLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: nil, bottom: nil)
        separatorView.anchor(top: containerView.topAnchor, leading: countLabel.trailingAnchor, trailing: nil, bottom: containerView.bottomAnchor, size: CGSize(width: 3, height: 0))
        titleLabel.anchor(top: countLabel.topAnchor, leading: separatorView.trailingAnchor, trailing: containerView.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 4))
        segmentedControl.anchor(top: nil, leading: nil, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor)
    }
    

}
