//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginTestButton(_ sender: Any) {
         //스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginNavigation") else {
            return
        }

        // 화면 전환방식 선택 (default : .modal)
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

        // 화면 전환!
        self.present(vc, animated: true)
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
