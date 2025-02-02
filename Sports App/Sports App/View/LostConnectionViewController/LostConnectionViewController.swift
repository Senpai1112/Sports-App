//
//  LostConnectionViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 02/02/2025.
//

import UIKit
import Lottie

class LostConnectionViewController: UIViewController {

    private var animationView : AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Internet unreachable", message: "you have to connect to the internet to use this app", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancle", style: .destructive, handler:nil))
        self.present(alert, animated: true)
    }
    func setupAnimationView(){
        animationView = .init(name: "ConnectionLost")
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .autoReverse
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
