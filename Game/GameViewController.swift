//
//  GameViewController.swift
//  Game
//
//  Created by 남경민 on 2022/12/14.
//

import UIKit


// 이미지 터치 시 사용
class CustomTap: UITapGestureRecognizer {
    var returnFlagIndex: Int?
    var ingredient: String?
}
enum Ingredient: String {
    case dough = "도우"
    case tomatoSauce = "토마토"
    case cheese = "치즈"
    case ham = "햄"
}

enum PizzaState: String {
    case start = "시작"
    case dough = "피자도우만"
    case tomatoSauce = "피자토마토소스"
    case cheese = "피자치즈"
    case ham = "피자햄"
    case end = "끝"
}

class GameViewController: UIViewController {
    
    // 메인 타이머
    var mainTimer:Timer = Timer()
    var mainCount:Int = 0
    var mainTimerCounting:Bool = false
    
    //현재 스코어
    var score = 0
    //현재 선택된 재료
    var selectedIngredient: String = ""
    
    var pizza1: Pizza = Pizza()
    var pizza2: Pizza = Pizza()
    var pizza3: Pizza = Pizza()
    var pizza4: Pizza = Pizza()

    // 게임 백그라운드 이미지
    @IBOutlet weak var gameBackImg: UIImageView!
    
    @IBOutlet weak var currentIngredient: UIImageView!
    
    // 재료 이미지
    @IBOutlet weak var doughImg: UIImageView!
    @IBOutlet weak var tomatoSauceImg: UIImageView!
    @IBOutlet weak var cheeseImg: UIImageView!
    @IBOutlet weak var hamImg: UIImageView!
    
    // 피자판 이미지
    @IBOutlet weak var plate1: UIImageView!
    @IBOutlet weak var plate2: UIImageView!
    @IBOutlet weak var plate3: UIImageView!
    @IBOutlet weak var plate4: UIImageView!
    
    // 오븐 1 피자 이미지
    @IBOutlet weak var oven1Before: UIImageView!
    @IBOutlet weak var oven1After: UIImageView!
    // 오븐 2 피자 이미지
    @IBOutlet weak var oven2Before: UIImageView!
    @IBOutlet weak var oven2After: UIImageView!
    // 오븐 3 피자 이미지
    @IBOutlet weak var oven3Before: UIImageView!
    @IBOutlet weak var oven3After: UIImageView!
    // 오븐 4 피자 이미지
    @IBOutlet weak var oven4Before: UIImageView!
    @IBOutlet weak var oven4After: UIImageView!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    func setUI() {
        gameBackImg.image = UIImage(named: "피자집배경")
        self.view.bringSubviewToFront(plate1)
        self.view.bringSubviewToFront(plate2)
        self.view.bringSubviewToFront(plate3)
        self.view.bringSubviewToFront(plate4)
        plate1.image = nil
        plate2.image = nil
        plate3.image = nil
        plate4.image = nil
        oven1After.image = nil
        oven1Before.image = nil
        oven2After.image = nil
        oven2Before.image = nil
        oven3After.image = nil
        oven3Before.image = nil
        oven4After.image = nil
        oven4Before.image = nil
        
        progressView.progressViewStyle = .default
        progressView.progressTintColor = .red
        progressView.trackTintColor = .lightGray
        progressView.progress = 1
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 3)
    
    }
    
    func tapAction() {
        // 도우 클릭 시
        let tapGesture1 = CustomTap(target: self, action: #selector(touchToIngredient(_:)))
        tapGesture1.ingredient = Ingredient.dough.rawValue
        doughImg.addGestureRecognizer(tapGesture1)
        doughImg.isUserInteractionEnabled = true
        
        // 토마토 소스 클릭 시
        let tapGesture2 = CustomTap(target: self, action: #selector(touchToIngredient(_:)))
        tapGesture2.ingredient = Ingredient.tomatoSauce.rawValue
        tomatoSauceImg.addGestureRecognizer(tapGesture2)
        tomatoSauceImg.isUserInteractionEnabled = true
        
        // 치즈 클릭 시
        let tapGesture3 = CustomTap(target: self, action: #selector(touchToIngredient(_:)))
        tapGesture3.ingredient = Ingredient.cheese.rawValue
        cheeseImg.addGestureRecognizer(tapGesture3)
        cheeseImg.isUserInteractionEnabled = true
        
        // 햄 클릭 시
        let tapGesture4 = CustomTap(target: self, action: #selector(touchToIngredient(_:)))
        tapGesture4.ingredient = Ingredient.ham.rawValue
        hamImg.addGestureRecognizer(tapGesture4)
        hamImg.isUserInteractionEnabled = true
        
        // 피자판1 클릭 시
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(touchToPlate1))
        plate1.addGestureRecognizer(tapGesture5)
        plate1.isUserInteractionEnabled = true

        // 피자판2 클릭 시
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(touchToPlate2))
        plate2.addGestureRecognizer(tapGesture6)
        plate2.isUserInteractionEnabled = true

        // 피자판3 클릭 시
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(touchToPlate3))
        plate3.addGestureRecognizer(tapGesture7)
        plate3.isUserInteractionEnabled = true

        // 피자판4 클릭 시
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(touchToPlate4))
        plate4.addGestureRecognizer(tapGesture8)
        plate4.isUserInteractionEnabled = true

        // 완성피자 클릭 시
        let tapGesture9 = CustomTap(target: self, action: #selector(touchToReturnPizza(_:)))
        tapGesture9.returnFlagIndex = 0
        oven1After.addGestureRecognizer(tapGesture9)
        oven1After.isUserInteractionEnabled = true
        // 완성피자 클릭 시
        let tapGesture10 = CustomTap(target: self, action: #selector(touchToReturnPizza(_:)))
        tapGesture10.returnFlagIndex = 1
        oven2After.addGestureRecognizer(tapGesture10)
        oven2After.isUserInteractionEnabled = true
        // 완성피자 클릭 시
        let tapGesture11 = CustomTap(target: self, action: #selector(touchToReturnPizza(_:)))
        tapGesture11.returnFlagIndex = 2
        oven3After.addGestureRecognizer(tapGesture11)
        oven3After.isUserInteractionEnabled = true
        // 완성피자 클릭 시
        let tapGesture12 = CustomTap(target: self, action: #selector(touchToReturnPizza(_:)))
        tapGesture12.returnFlagIndex = 3
        oven4After.addGestureRecognizer(tapGesture12)
        oven4After.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tapAction()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        mainLoop()
    }
    override func viewDidDisappear(_ animated: Bool) {
        scoreLabel.text = String(score)
        if(pizza1.timerCounting){
            pizza1.timer.invalidate()
        }
        if(pizza2.timerCounting){
            pizza2.timer.invalidate()
        }
        if(pizza3.timerCounting){
            pizza3.timer.invalidate()
        }
        if(pizza4.timerCounting){
            pizza4.timer.invalidate()
        }
        if(mainTimerCounting){
            mainTimer.invalidate()
        }
        mainTimerCounting = false
    }
    // 완성된 피자 클릭 -> 완성된 피자 회수
    @objc func touchToReturnPizza(_ sender: Any){
        if let tag = (sender as! CustomTap).returnFlagIndex {
            if (tag == 0) {
                pizza1.returnFlag = true
            }
            if (tag == 1) {
                pizza2.returnFlag = true
            }
            if (tag == 2) {
                pizza3.returnFlag = true
            }
            if (tag == 3) {
                pizza4.returnFlag = true
            }
        }
    }
    // 재료 클릭
    @objc func touchToIngredient(_ sender: Any) {
        if let ingred = (sender as! CustomTap).ingredient {
            currentIngredient.image = UIImage(named: ingred)
            selectedIngredient = ingred
        }
        
    }
    
    // 피자판 1 클릭
    @objc func touchToPlate1() {
        if(selectedIngredient == Ingredient.dough.rawValue && pizza1.state ==
           PizzaState.start.rawValue) {
            pizza1.state = PizzaState.dough.rawValue
            pizza1.imageName = PizzaState.dough.rawValue
            plate1.image = UIImage(named: pizza1.imageName)
            
        } else if(selectedIngredient == Ingredient.tomatoSauce.rawValue && pizza1.state == PizzaState.dough.rawValue) {
            pizza1.state = PizzaState.tomatoSauce.rawValue
            pizza1.imageName = PizzaState.tomatoSauce.rawValue
            plate1.image = UIImage(named: pizza1.imageName)
        } else if(selectedIngredient == Ingredient.cheese.rawValue && pizza1.state == PizzaState.tomatoSauce.rawValue) {
            pizza1.state = PizzaState.cheese.rawValue
            pizza1.imageName = PizzaState.cheese.rawValue
            plate1.image = UIImage(named: pizza1.imageName)
        } else if(selectedIngredient == Ingredient.ham.rawValue && pizza1.state == PizzaState.cheese.rawValue) {
            pizza1.state = PizzaState.ham.rawValue
            pizza1.imageName = PizzaState.ham.rawValue
            plate1.image = UIImage(named: pizza1.imageName)
        } else if( pizza1.state == PizzaState.ham.rawValue) {
            //피자 완성
            pizza1.state = PizzaState.start.rawValue
            plate1.image = nil
            // 오븐에 피자 갖다놓기
            self.oven1()
        } else {
            self.showToast(message: "조리 순서가 틀렸습니다.")
        }
    }
    
    func oven1() {
        // false : 타이머 시작 전
        if(!pizza1.timerCounting){
            oven1Before.image = UIImage(named: PizzaState.ham.rawValue)
            //DispatchQueue.global(qos: .userInitiated).async { [self] in
            pizza1.timerCounting = true
            let runLoop = RunLoop.current
            pizza1.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            
            while pizza1.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
            //}
        // true : 타이머 시작 후
        }else {
                
        }
    }
    @objc func timerCounter() -> Void
    {
        pizza1.count = pizza1.count + 1
        
        if(pizza1.count<=5){
            oven1Before.image = nil
            print("🍕 pizza1 : " + String(pizza1.count) + "초")
        }
        else{
            pizza1.timer.invalidate()
            pizza1.timerCounting = false
            print("⏰ 타이머 종료")
            pizza1.count = 0
            //DispatchQueue.main.sync {
            self.oven1After.image = UIImage(named: "피자완성")
            
            //}
            
            // 5초 카운트 다시 시작
            pizza1.timerCounting = true
            let runLoop = RunLoop.current
            pizza1.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(returnCounter), userInfo: nil, repeats: true)
            
            while pizza1.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }

        }
    }
    
    @objc func returnCounter() {
        pizza1.count = pizza1.count + 1
        if(pizza1.count<=5){
            print("🍕 returnpizza1 : " + String(pizza1.count) + "초")
            if(pizza1.returnFlag) {
                pizza1.timer.invalidate()
                pizza1.timerCounting = false
                pizza1.count = 0
                //DispatchQueue.main.sync {
                
                self.oven1After.image = UIImage(named: "웃는모습")
                score += 10000
                scoreLabel.text = String(score)
                //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                  // 1초 후 실행될 부분
                RunLoop.current.run(until: Date().advanced(by: 1))
                self.oven1After.image = nil
                //}
                
                pizza1.returnFlag = false
                //}
            }
        } else {
            pizza1.timer.invalidate()
            pizza1.timerCounting = false
            pizza1.count = 0
            
            self.oven1After.image = UIImage(named: "탄피자")
            //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              // 1초 후 실행될 부분
            RunLoop.current.run(until: Date().advanced(by: 1))
            self.oven1After.image = nil
            //}
            
            pizza1.returnFlag = false
        }
    }
    
    // 피자판 2 클릭
    @objc func touchToPlate2() {
        if(selectedIngredient == Ingredient.dough.rawValue && pizza2.state ==
           PizzaState.start.rawValue) {
            pizza2.state = PizzaState.dough.rawValue
            pizza2.imageName = PizzaState.dough.rawValue
            plate2.image = UIImage(named: pizza2.imageName)
            
        } else if(selectedIngredient == Ingredient.tomatoSauce.rawValue && pizza2.state == PizzaState.dough.rawValue) {
            pizza2.state = PizzaState.tomatoSauce.rawValue
            pizza2.imageName = PizzaState.tomatoSauce.rawValue
            plate2.image = UIImage(named: pizza2.imageName)
        } else if(selectedIngredient == Ingredient.cheese.rawValue && pizza2.state == PizzaState.tomatoSauce.rawValue) {
            pizza2.state = PizzaState.cheese.rawValue
            pizza2.imageName = PizzaState.cheese.rawValue
            plate2.image = UIImage(named: pizza2.imageName)
        } else if(selectedIngredient == Ingredient.ham.rawValue && pizza2.state == PizzaState.cheese.rawValue) {
            pizza2.state = PizzaState.ham.rawValue
            pizza2.imageName = PizzaState.ham.rawValue
            plate2.image = UIImage(named: pizza2.imageName)
        } else if( pizza2.state == PizzaState.ham.rawValue) {
            //피자 완성
            pizza2.state = PizzaState.start.rawValue
            plate2.image = nil
            // 오븐에 피자 갖다놓기
            self.oven2()
        } else {
            self.showToast(message: "조리 순서가 틀렸습니다.")
        }
    }
    
    func oven2() {
        // false : 타이머 시작 전
        if(!pizza2.timerCounting){
            oven2Before.image = UIImage(named: PizzaState.ham.rawValue)
            //DispatchQueue.global(qos: .userInitiated).async { [self] in
            pizza2.timerCounting = true
            let runLoop = RunLoop.current
            pizza2.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter2), userInfo: nil, repeats: true)
            
            while pizza2.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
            //}
        // true : 타이머 시작 후
        }else {
                
        }
    }
    @objc func timerCounter2() -> Void
    {
        pizza2.count = pizza2.count + 1
        
        if(pizza2.count<=5){
            oven2Before.image = nil
            print("🍕 pizza2 : " + String(pizza2.count) + "초")
        }
        else{
            pizza2.timer.invalidate()
            pizza2.timerCounting = false
            print("⏰ 타이머 종료")
            pizza2.count = 0
            //DispatchQueue.main.sync {
            self.oven2After.image = UIImage(named: "피자완성")
            
            //}
            
            // 5초 카운트 다시 시작
            pizza2.timerCounting = true
            let runLoop = RunLoop.current
            pizza2.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(returnCounter2), userInfo: nil, repeats: true)
            
            while pizza2.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }

        }
    }
    
    @objc func returnCounter2() {
        pizza2.count = pizza2.count + 1
        if(pizza2.count<=5){
            print("🍕 returnpizza2 : " + String(pizza2.count) + "초")
            if(pizza2.returnFlag) {
                pizza2.timer.invalidate()
                pizza2.timerCounting = false
                pizza2.count = 0
                //DispatchQueue.main.sync {
                
                self.oven2After.image = UIImage(named: "웃는모습")
                score += 10000
                scoreLabel.text = String(score)
                //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                  // 1초 후 실행될 부분
                RunLoop.current.run(until: Date().advanced(by: 1))
                self.oven2After.image = nil
                //}
                
                pizza2.returnFlag = false
                //}
            }
        } else {
            pizza2.timer.invalidate()
            pizza2.timerCounting = false
            pizza2.count = 0
            
            self.oven2After.image = UIImage(named: "탄피자")
            //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              // 1초 후 실행될 부분
            RunLoop.current.run(until: Date().advanced(by: 1))
            self.oven2After.image = nil
            //}
            
            pizza2.returnFlag = false
        }
    }

    // 피자판 3 클릭
    @objc func touchToPlate3() {
        if(selectedIngredient == Ingredient.dough.rawValue && pizza3.state ==
           PizzaState.start.rawValue) {
            pizza3.state = PizzaState.dough.rawValue
            pizza3.imageName = PizzaState.dough.rawValue
            plate3.image = UIImage(named: pizza3.imageName)
            
        } else if(selectedIngredient == Ingredient.tomatoSauce.rawValue && pizza3.state == PizzaState.dough.rawValue) {
            pizza3.state = PizzaState.tomatoSauce.rawValue
            pizza3.imageName = PizzaState.tomatoSauce.rawValue
            plate3.image = UIImage(named: pizza3.imageName)
        } else if(selectedIngredient == Ingredient.cheese.rawValue && pizza3.state == PizzaState.tomatoSauce.rawValue) {
            pizza3.state = PizzaState.cheese.rawValue
            pizza3.imageName = PizzaState.cheese.rawValue
            plate3.image = UIImage(named: pizza3.imageName)
        } else if(selectedIngredient == Ingredient.ham.rawValue && pizza3.state == PizzaState.cheese.rawValue) {
            pizza3.state = PizzaState.ham.rawValue
            pizza3.imageName = PizzaState.ham.rawValue
            plate3.image = UIImage(named: pizza3.imageName)
        } else if( pizza3.state == PizzaState.ham.rawValue) {
            //피자 완성
            pizza3.state = PizzaState.start.rawValue
            plate3.image = nil
            // 오븐에 피자 갖다놓기
            self.oven3()
        } else {
            self.showToast(message: "조리 순서가 틀렸습니다.")
        }
    }
    
    func oven3() {
        // false : 타이머 시작 전
        if(!pizza3.timerCounting){
            oven3Before.image = UIImage(named: PizzaState.ham.rawValue)
            //DispatchQueue.global(qos: .userInitiated).async { [self] in
            pizza3.timerCounting = true
            let runLoop = RunLoop.current
            pizza3.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter3), userInfo: nil, repeats: true)
            
            while pizza3.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
            //}
        // true : 타이머 시작 후
        }else {
                
        }
    }
    @objc func timerCounter3() -> Void
    {
        pizza3.count = pizza3.count + 1
        
        if(pizza3.count<=5){
            oven3Before.image = nil
            print("🍕 pizza3 : " + String(pizza3.count) + "초")
        }
        else{
            pizza3.timer.invalidate()
            pizza3.timerCounting = false
            print("⏰ 타이머 종료")
            pizza3.count = 0
            //DispatchQueue.main.sync {
            self.oven3After.image = UIImage(named: "피자완성")
            
            //}
            
            // 5초 카운트 다시 시작
            pizza3.timerCounting = true
            let runLoop = RunLoop.current
            pizza3.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(returnCounter3), userInfo: nil, repeats: true)
            
            while pizza3.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }

        }
    }
    
    @objc func returnCounter3() {
        pizza3.count = pizza3.count + 1
        if(pizza3.count<=5){
            print("🍕 returnpizza3 : " + String(pizza3.count) + "초")
            if(pizza3.returnFlag) {
                pizza3.timer.invalidate()
                pizza3.timerCounting = false
                pizza3.count = 0
                //DispatchQueue.main.sync {
                
                self.oven3After.image = UIImage(named: "웃는모습")
                score += 10000
                scoreLabel.text = String(score)
                //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                  // 1초 후 실행될 부분
                RunLoop.current.run(until: Date().advanced(by: 1))
                self.oven3After.image = nil
                //}
                
                pizza3.returnFlag = false
                //}
            }
        } else {
            pizza3.timer.invalidate()
            pizza3.timerCounting = false
            pizza3.count = 0
            
            self.oven3After.image = UIImage(named: "탄피자")
            //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              // 1초 후 실행될 부분
            RunLoop.current.run(until: Date().advanced(by: 1))
            self.oven3After.image = nil
            //}
            
            pizza3.returnFlag = false
        }
    }
    // 피자판 4 클릭
    @objc func touchToPlate4() {
        if(selectedIngredient == Ingredient.dough.rawValue && pizza4.state ==
           PizzaState.start.rawValue) {
            pizza4.state = PizzaState.dough.rawValue
            pizza4.imageName = PizzaState.dough.rawValue
            plate4.image = UIImage(named: pizza4.imageName)
            
        } else if(selectedIngredient == Ingredient.tomatoSauce.rawValue && pizza4.state == PizzaState.dough.rawValue) {
            pizza4.state = PizzaState.tomatoSauce.rawValue
            pizza4.imageName = PizzaState.tomatoSauce.rawValue
            plate4.image = UIImage(named: pizza4.imageName)
        } else if(selectedIngredient == Ingredient.cheese.rawValue && pizza4.state == PizzaState.tomatoSauce.rawValue) {
            pizza4.state = PizzaState.cheese.rawValue
            pizza4.imageName = PizzaState.cheese.rawValue
            plate4.image = UIImage(named: pizza4.imageName)
        } else if(selectedIngredient == Ingredient.ham.rawValue && pizza4.state == PizzaState.cheese.rawValue) {
            pizza4.state = PizzaState.ham.rawValue
            pizza4.imageName = PizzaState.ham.rawValue
            plate4.image = UIImage(named: pizza4.imageName)
        } else if( pizza4.state == PizzaState.ham.rawValue) {
            //피자 완성
            pizza4.state = PizzaState.start.rawValue
            plate4.image = nil
            // 오븐에 피자 갖다놓기
            self.oven4()
        } else {
            self.showToast(message: "조리 순서가 틀렸습니다.")
        }
    }
    
    func oven4() {
        // false : 타이머 시작 전
        if(!pizza4.timerCounting){
            oven4Before.image = UIImage(named: PizzaState.ham.rawValue)
            //DispatchQueue.global(qos: .userInitiated).async { [self] in
            pizza4.timerCounting = true
            let runLoop = RunLoop.current
            pizza4.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter4), userInfo: nil, repeats: true)
            
            while pizza4.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
            //}
        // true : 타이머 시작 후
        }else {
                
        }
    }
    @objc func timerCounter4() -> Void
    {
        pizza4.count = pizza4.count + 1
        
        if(pizza4.count<=5){
            oven4Before.image = nil
            print("🍕 pizza4 : " + String(pizza4.count) + "초")
        }
        else{
            pizza4.timer.invalidate()
            pizza4.timerCounting = false
            print("⏰ 타이머 종료")
            pizza4.count = 0
            //DispatchQueue.main.sync {
            self.oven4After.image = UIImage(named: "피자완성")
            
            //}
            
            // 5초 카운트 다시 시작
            pizza4.timerCounting = true
            let runLoop = RunLoop.current
            pizza4.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(returnCounter4), userInfo: nil, repeats: true)
            
            while pizza4.timerCounting{
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }

        }
    }

    @objc func returnCounter4() {
        pizza4.count = pizza4.count + 1
        if(pizza4.count<=5){
            print("🍕 returnpizza4 : " + String(pizza4.count) + "초")
            if(pizza4.returnFlag) {
                pizza4.timer.invalidate()
                pizza4.timerCounting = false
                pizza4.count = 0
                //DispatchQueue.main.sync {
                
                self.oven4After.image = UIImage(named: "웃는모습")
                score += 10000
                scoreLabel.text = String(score)
                //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                  // 1초 후 실행될 부분
                RunLoop.current.run(until: Date().advanced(by: 1))
                self.oven4After.image = nil
                //}
                
                pizza4.returnFlag = false
                //}
            }
        } else {
            pizza4.timer.invalidate()
            pizza4.timerCounting = false
            pizza4.count = 0
            
            self.oven4After.image = UIImage(named: "탄피자")
            //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              // 1초 후 실행될 부분
            RunLoop.current.run(until: Date().advanced(by: 1))
            self.oven4After.image = nil
            //}
            
            pizza4.returnFlag = false
        }
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
    //메인 타이머 카운터
    @objc func mainTimerCounter() -> Void
    {
        mainCount = mainCount + 1
        
        if(mainCount<=60){
            print("⏳ 남은 게임 시간 : " + String(60-mainCount) + "초")
            progressView.setProgress(progressView.progress - 0.0167, animated: true)
        }
        else{
            mainTimer.invalidate()
            mainTimerCounting = false
            pizza1.timer.invalidate()
            pizza1.timerCounting = false
            pizza2.timer.invalidate()
            pizza2.timerCounting = false
            pizza3.timer.invalidate()
            pizza3.timerCounting = false
            pizza4.timer.invalidate()
            pizza4.timerCounting = false
            print("😇 게임 종료")
            
            if(score >= 100000){
                // 다음 컨트롤러에 대한 인스턴스 생성
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as? GameOverViewController else { return }
                vc.score = self.score
                vc.modalPresentationStyle = .fullScreen
                // 화면을 전환하다.
                present(vc, animated: true)
            } else {
                // 다음 컨트롤러에 대한 인스턴스 생성
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameFailedViewController") as? GameFailedViewController else { return }
                vc.score = self.score
                vc.modalPresentationStyle = .fullScreen
                // 화면을 전환하다.
                present(vc, animated: true)
            }
        }
    }
    
    //메인 루프
    func mainLoop(){
        mainTimerCounting = true
        let runLoop = RunLoop.current
        mainTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainTimerCounter), userInfo: nil, repeats: true)
        
        while mainTimerCounting{
            runLoop.run(until: Date().addingTimeInterval(0.1))
        }
    }
                                     
    //토스트 메시지
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview()})
        
    }
    
    
}
