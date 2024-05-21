//
//  ToastWindow.swift
//  CustomAlertController
//
//  Created by Akash on 06/05/24.
//

import Foundation
import UIKit

class ToastWindow: UIWindow {
    static let shared = ToastWindow()

    private let maxWidth: CGFloat = {
        return UIScreen.main.bounds.width - 32
    }()
    private let padding: CGFloat = 10
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()

    private init() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene{
            super.init(windowScene: windowScene)
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        self.backgroundColor = .clear
        self.windowLevel = .normal
        self.isUserInteractionEnabled = false
        self.addSubview(toastLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showToast(message: String) {
        self.makeKeyAndVisible()
        toastLabel.text = message
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth - 2 * padding, height: .greatestFiniteMagnitude))
        let labelWidth = min(textSize.width + 2 * padding, maxWidth)
        let labelHeight = textSize.height + 2 * padding
        toastLabel.frame = CGRect(x: (UIScreen.main.bounds.width - labelWidth) / 2,
                                  y: UIScreen.main.bounds.height - labelHeight - 100,
                                  width: labelWidth,
                                  height: labelHeight)

        let originalY = toastLabel.frame.origin.y
        toastLabel.frame.origin.y = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.33, delay: 0.2, animations: {
            self.toastLabel.frame.origin.y = originalY
        }, completion: { _ in
            UIView.animate(withDuration: 0.33, delay: 2, animations: {
                self.toastLabel.frame.origin.y = UIScreen.main.bounds.height
            }, completion: { _ in
                self.resignKey()
                self.isHidden = true
            })
        })
    }
}
