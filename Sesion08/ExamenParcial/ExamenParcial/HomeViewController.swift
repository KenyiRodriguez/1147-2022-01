//
//  HomeViewController.swift
//  ExamenParcial
//
//  Created by Kenyi Rodriguez on 8/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var anchorBottom: NSLayoutConstraint!
    @IBOutlet private weak var lblContent: UILabel!
    
    private var isColapse = false
    
    @IBAction private func clickBtnSeeMore(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.lblContent.numberOfLines = self.isColapse ? 2 : 0
            sender.setTitle(self.isColapse ? "Ver más" : "Ver menos", for: .normal)
            self.isColapse = !self.isColapse
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func tapToClose(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardEvents()
    }
}

extension HomeViewController {
    
    private func registerKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorBottom.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

