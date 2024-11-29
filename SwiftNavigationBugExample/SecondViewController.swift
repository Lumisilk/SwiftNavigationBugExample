//
//  SheetViewController.swift
//  SwiftNavigationBugExample
//
//  Created by lumisilk on 2024/11/29.
//

import UIKit
import UIKitNavigation

@Observable
private class ViewModel {
    var isThirdVCPresented = false
    
    init() {
        print("ViewModel \(ObjectIdentifier(self)) init")
    }
    deinit {
        print("ViewModel \(ObjectIdentifier(self)) deinit")
    }
}

class SheetViewController: UIViewController {

    @UIBindable private var viewModel = ViewModel()
    
    deinit {
        print("SheetViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // viewModel will Not be deinited
        present(isPresented: $viewModel.isThirdVCPresented) { [viewModel] in
            _ = viewModel
            return SheetViewController()
        }
        
        // viewModel will be deinited
//        observe { [viewModel] in
//            _ = viewModel
//        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        let primaryButton = UIButton(type: .system)
        primaryButton.setTitle("Present", for: .normal)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)

        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)

        view.addSubview(primaryButton)
        view.addSubview(dismissButton)

        NSLayoutConstraint.activate([
            primaryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),

            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 20)
        ])
    }

    @objc private func primaryButtonTapped() {
        viewModel.isThirdVCPresented = true
    }

    @objc private func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
