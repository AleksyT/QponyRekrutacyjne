//
//  EntryAnimationViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import UIKit
import Lottie

class EntryAnimationViewController: UIViewController {
    
    private static let animationName = "coinsAnimation"
    
    var animationView: AnimationView?

    @IBOutlet private var coinsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    fileprivate func initialize() {
        makeAnimationView()
        playPoppingCoinsAnimation()
    }
    
    fileprivate func makeAnimationView() {
        animationView = AnimationView(name: Self.animationName)
        animationView?.center = self.view.center
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .playOnce
        view.addSubview(animationView!)
        
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        
        animationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func playPoppingCoinsAnimation() {
        self.animationView?.play(completion: { [weak self] _ in
            let mainScreen = MainScreenViewController.loadFromNib()
            let navigationController = UINavigationController(rootViewController: mainScreen)
            navigationController.navigationBar.isHidden = true
            self?.present(navigationController, animated: true)
        })
    }
}
