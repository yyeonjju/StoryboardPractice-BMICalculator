//
//  BMIViewController.swift
//  SesacAssignment0521
//
//  Created by 하연주 on 5/21/24.
//

import UIKit

class BMIViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    
    @IBOutlet var answerHeightLabel: UILabel!
    @IBOutlet var answerWeightLabel: UILabel!
    
    
    @IBOutlet var inputHeightTextField: UITextField!
    @IBOutlet var inputWeightTextField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var randomCalculateButton: UIButton!
    @IBOutlet var showResultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI () {
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        subTitleLabel.text = "당신의 BMI 지수를 \n 알려드릴게요"
        subTitleLabel.numberOfLines = 2
        subTitleLabel.textAlignment = .left
        
        answerHeightLabel.text = "키가 어떻게 되시나요?"
        answerHeightLabel.textColor = .gray
        answerWeightLabel.text = "몸무게는 어떻게 되시나요?"
        answerWeightLabel.textColor = .gray
        
        imageView.image = UIImage(named: "image")
        
        
        [inputHeightTextField, inputWeightTextField]
            .forEach{
                $0.layer.cornerRadius = 20
                $0.layer.borderWidth = 2
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.keyboardType = .numberPad
            }
        
        randomCalculateButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomCalculateButton.setTitleColor(.red, for: .normal)
        
        showResultButton.setTitle("결과 확인", for: .normal)
        showResultButton.layer.cornerRadius = 10
        showResultButton.backgroundColor = .purple
        showResultButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func showResultButtonTapped(_ sender: UIButton) {
        if let height = Int(inputHeightTextField.text ?? ""), let weight = Int(inputWeightTextField.text ?? "") {
            
            let bmi = calculateBMI(weight: weight, height: height)
            showResultAlertButton(bmiResult: String(bmi))
    
        }
    }
    
    @IBAction func randomCalculateButtonTapped(_ sender: UIButton) {
        let randomHeight = Int.random(in: 100...200)
        let randomWeight = Int.random(in: 50...150)
        inputHeightTextField.text = String(randomHeight)
        inputWeightTextField.text = String(randomWeight)
        
        showResultButtonTapped(showResultButton)
        
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func calculateBMI(weight: Int, height : Int) -> Int{
        return weight/(height/100*height/100)
    }
    
    private func showResultAlertButton (bmiResult : String) {
        let alertTitle = "BMI : \(bmiResult)"
        //1. 얼럿 컨트롤러
        let altert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        //2. 버튼
        let confirm = UIAlertAction(title: "확인", style: .default)
        //3. 액션 버튼 붙이기
        altert.addAction(confirm)
        //4. 얼럿 띄워주기
        present(altert, animated: true)
    }

}
