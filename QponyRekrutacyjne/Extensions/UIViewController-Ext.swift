//
//  UIViewController-Ext.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import UIKit

private func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
       let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UIViewController {
    static let preventPageSheetPresentation: Void = {
            if #available(iOS 13, *) {
                _swizzling(forClass: UIViewController.self,
                           originalSelector: #selector(present(_: animated: completion:)),
                           swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
            }
        }()

        @available(iOS 13.0, *)
        @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                            animated flag: Bool,
                                            completion: (() -> Void)? = nil) {
            if viewControllerToPresent.modalPresentationStyle == .pageSheet
                       || viewControllerToPresent.modalPresentationStyle == .automatic {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
            _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
        }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
    func attachChild(_  viewController: UIViewController, inside contentView: UIView? = nil) {
        let contentView: UIView = contentView ?? view
        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.frame = contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
