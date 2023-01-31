//
//  BottomSheet.swift
//  Test
//
//  Created by Vanya Bogdantsev on 30.01.2023.
//

import UIKit

final class BottomSheetViewController: UIViewController {
    
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return 600
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        roundView()
        attachGesture()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        defineFrame(basedOn: parent)
    }
    
    private func roundView() {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    
    private func attachGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self,
                                                  action: #selector(dragAndDetent(_ :)))
        view.addGestureRecognizer(gesture)
    }
    
    private func defineFrame(basedOn parent: UIViewController?) {
        guard let frame = parent?.view.frame else { return }
        view.frame = CGRect(x: frame.minX, y: 600,
                            width: frame.width,
                            height: frame.height)
    }
    
    @objc fileprivate func dragAndDetent(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        
        self.view.frame.origin.y += translation.y
        recognizer.setTranslation(CGPoint.zero, in: view)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.3, delay: .nan, animations: {
                self.view.frame.origin.y = self.view.frame.origin.y > 350 ? self.partialView : self.fullView
            })
        }
    }
    
}
