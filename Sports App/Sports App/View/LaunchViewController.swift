//
//  ViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 26/01/2025.
//

import UIKit
import Lottie

class LaunchViewController : UIViewController {
    private var animationView : AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemCyan
        setupAnimationView()
    }
    func setupAnimationView(){
        animationView = .init(name: "MainScene")
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play(){_ in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let firstViewController = storyBoard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController?
            UIApplication.shared.windows.first?.rootViewController = firstViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

}

