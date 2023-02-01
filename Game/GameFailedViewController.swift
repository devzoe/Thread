//
//  GameFailedViewController.swift
//  Game
//
//  Created by 남경민 on 2022/12/17.
//

import UIKit

class GameFailedViewController: UIViewController {
    var score: Int = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = String(score)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToImage))
        startImg.addGestureRecognizer(tapGesture)
        startImg.isUserInteractionEnabled = true
    }
    
    @objc func touchToImage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameVC = storyboard.instantiateViewController(identifier: "GameViewController") as? GameViewController else {
            print("Controller not found")
            return
        }
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
    }
    

    
    //화면 가로로 설정
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }

}
