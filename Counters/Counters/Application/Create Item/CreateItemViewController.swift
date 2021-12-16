//
//  CreateItemViewController.swift
//  Counters
//
//  Created by Abner Abbey on 13/12/21.
//

import UIKit

class CreateItemViewController: UIViewController {
    
    private lazy var textFieldView: UIView = create {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
    }
    
    private lazy var textField: UITextField = create {
        $0.placeholder = viewModel?.uiConfig.placeholder
    }
    
    var viewModel: CreateItemViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = viewModel?.uiConfig.background
        title = viewModel?.uiConfig.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel?.uiConfig.leftButtonTitle, style: .plain, target: self, action: #selector(CreateItemViewController.cancelView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel?.uiConfig.rightButtonTitle, style: .done, target: nil, action: nil)
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        textFieldView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 58))
        textField.anchor(top: textFieldView.topAnchor, leading: textFieldView.leadingAnchor, trailing: textFieldView.trailingAnchor, bottom: textFieldView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        textField.becomeFirstResponder()
    }
    
    @objc private func cancelView() {
        dismiss(animated: true, completion: nil)
    }

}
