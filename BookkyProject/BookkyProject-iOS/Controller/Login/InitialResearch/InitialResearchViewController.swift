//
//  InitialResearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class InitialResearchViewController: UIViewController {

    @IBOutlet weak var answerNOButton: UIButton!
    @IBOutlet weak var answerYESButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var isanswerNOButtonSelected: Bool = false
    var isanswerYESButtonSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultView()
        self.navigationController?.navigationBar.tintColor = UIColor(named: "lightGrayColor")
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setDefaultView() {
        self.answerNOButton.layer.cornerRadius = 8.0
        self.answerYESButton.layer.cornerRadius = 8.0
        self.nextButton.layer.cornerRadius = 8.0

    }
    
    @IBAction func answerNoButtonSelected(_ sender: UIButton) {
        self.answerNOButton.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        self.answerNOButton.setTitleColor(UIColor(named: "White Color"), for: .normal)
        
        self.answerYESButton.layer.backgroundColor = UIColor(named: "lightGrayColor")?.cgColor
        self.answerYESButton.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        
        self.isanswerNOButtonSelected = true
        self.isanswerYESButtonSelected = false
        
        self.nextButton.isEnabled = true
        self.nextButton.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        self.nextButton.setTitleColor(UIColor(named: "White Color"), for: .normal)
    }
    
    @IBAction func answerYesButtonSelected(_ sender: UIButton) {
        self.answerYESButton.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        self.answerYESButton.setTitleColor(UIColor(named: "White Color"), for: .normal)
        self.answerNOButton.layer.backgroundColor = UIColor(named: "lightGrayColor")?.cgColor
        self.answerNOButton.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        
        self.isanswerYESButtonSelected = true
        self.isanswerYESButtonSelected = false
        
        self.nextButton.isEnabled = true
        self.nextButton.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        self.nextButton.setTitleColor(UIColor(named: "White Color"), for: .normal)
    }
}

// MARK: - Button Extension
extension UIButton {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
    }
    
}
