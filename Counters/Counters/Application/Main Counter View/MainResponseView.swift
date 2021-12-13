//
//  MainResponseView.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import UIKit

class MainResponseView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let titleLabel: UILabel = .withConfig(.init(font: UIFont.systemFont(ofSize: 22, weight: .bold), textColor: UIColor(named: "PrimaryText")!))
    let descriptionLabel: UILabel = .withConfig(.init(font: UIFont.systemFont(ofSize: 17, weight: .regular), textColor: UIColor(named: "SecondaryText")!))
    let actionButton: Button = Button()
    
    struct ViewModel {
        let title: String
        let description: String
        let buttonTitle: String
        let action: (UIButton) -> ()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
        
        titleLabel.centerAnchors(centerX: centerXAnchor, centerY: centerYAnchor)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        actionButton.anchor(top: descriptionLabel.bottomAnchor, leading: nil, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 44))
        actionButton.centerAnchors(centerX: centerXAnchor, centerY: nil)
        
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        
    }
    
    func configue(withViewModel viewModel: MainResponseView.ViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
        actionButton.addTarget(viewModel.action)
    }
    

}
