//
//  SwiftNavigationBugExampleApp.swift
//  SwiftNavigationBugExample
//
//  Created by lumisilk on 2024/11/29.
//

import SwiftUI

@main
struct SwiftNavigationBugExampleApp: App {
    var body: some Scene {
        WindowGroup {
            RootViewControllerAdapter()
        }
    }
}

private struct RootViewControllerAdapter: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RootViewController {
        RootViewController()
    }

    func updateUIViewController(_ uiViewController: RootViewController, context: Context) {}
}

/// Just a plain VC to present SheetViewController
private class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func buttonTapped() {
        present(SheetViewController(), animated: true)
    }
}
