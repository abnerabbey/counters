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
    
    private lazy var activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    var viewModel: CreateItemViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binds()
    }
    
    private func setupView() {
        view.backgroundColor = viewModel?.uiConfig.background
        title = viewModel?.uiConfig.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel?.uiConfig.leftButtonTitle, style: .plain, target: self, action: #selector(CreateItemViewController.cancelView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel?.uiConfig.rightButtonTitle, style: .done, target: self, action: #selector(CreateItemViewController.saveAction))
        
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        textFieldView.addSubview(activityView)
        
        textFieldView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 58))
        activityView.anchor(top: nil, leading: nil, trailing: textFieldView.trailingAnchor, bottom: nil, size: CGSize(width: 40, height: 40))
        activityView.centerAnchors(centerX: nil, centerY: textFieldView.centerYAnchor)
        textField.anchor(top: textFieldView.topAnchor, leading: textFieldView.leadingAnchor, trailing: activityView.leadingAnchor, bottom: textFieldView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        textField.becomeFirstResponder()
    }
    
    @objc private func cancelView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveAction() {
        viewModel?.createCount(withTitle: textField.text)
    }

}

// MARK: - Binding
extension CreateItemViewController {
    
    private func binds() {
        bindFetchState()
    }
    
    private func bindFetchState() {
        viewModel?.state.bind({ [weak self] state in
            guard let state = state else { return }
            switch state {
            case .fetching:
                self?.activityView.startAnimating()
            case .success:
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self?.activityView.stopAnimating()
                self?.showAlert(withMessage: error.localizedDescription)
            }
        })
    }
    
}
