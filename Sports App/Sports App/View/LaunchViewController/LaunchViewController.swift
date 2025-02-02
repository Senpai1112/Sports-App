//
//  ViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 26/01/2025.
//

import UIKit
import Lottie
import Reachability

class LaunchViewController : UIViewController {
    private var animationView : AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            // Instantiate the Tab Bar Controller from the storyboard
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                // Wrap the Tab Bar Controller in a Navigation Controller
                let navigationController = UINavigationController(rootViewController: tabBarController)

                // Access the window using the connectedScenes
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    // Set the Navigation Controller as the root view controller
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
            }
        }
    }

}

