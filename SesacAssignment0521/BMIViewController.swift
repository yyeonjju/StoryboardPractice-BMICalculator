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
    @IBOutlet var nicknameLabel: UILabel!
    
    
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
        setData()
        
    }
    private func setData() {
        let heightData = UserDefaults.standard.string(forKey: "height")
        inputHeightTextField.text = heightData
        let weightData = UserDefaults.standard.string(forKey: "weight")
        inputWeightTextField.text = weightData
        let nicknameData = UserDefaults.standard.string(forKey: "nickname")
        nicknameLabel.text = "닉네임 : \(nicknameData ?? "")"
    }
    
    private func configureUI () {
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        subTitleLabel.text = "당신의 BMI 지수를 \n알려드릴게요"
        subTitleLabel.numberOfLines = 2
        subTitleLabel.textAlignment = .left
        subTitleLabel.font = .systemFont(ofSize: 13)
        
        nicknameLabel.text = "닉네임 : "
        nicknameLabel.textColor = .brown
        
        answerHeightLabel.text = "키가 어떻게 되시나요?"
        answerHeightLabel.textColor = .gray
        answerWeightLabel.text = "몸무게는 어떻게 되시나요?"
        answerWeightLabel.textColor = .gray
        
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        
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
            var resultText : String
            
            if let validateString = validateString(height: height, weight: weight) {
                resultText = validateString
            } else {
                let bmi = calculateBMI(weight: weight, height: height)
                resultText =  "BMI : \(bmi)"
                
            }
            
            showResultAlertButton(resultText: resultText, height: height, weight: weight)
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
    
    private func validateString(height : Int, weight : Int) -> String? {
        if height <= 250 && weight < 250 {
            return nil
        } else {
            return "키와 몸무게를 다시 확인해주세요"
        }
    }
    
    private func saveToUserDefaults (height : Int, weight : Int, nickname : String) {
        //UserDefaults에 키와 몸무게 값 저장
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")
        UserDefaults.standard.set(nickname, forKey: "nickname")
    }
    
    private func calculateBMI(weight: Int, height : Int) -> Double{
        let bmi = Double(weight)/(Double(height)/100*Double(height)/100)
        let roundedBMI = round(bmi*100)/100
        return roundedBMI
    }
    
    private func showResultAlertButton (resultText: String, height : Int, weight : Int) {
        //1. 얼럿 컨트롤러
        let altert = UIAlertController(title: resultText, message: "닉네임을 입력하셔야 결과가 저장됩니다.", preferredStyle: .alert)
        altert.addTextField{nicknameTextField in
            nicknameTextField.placeholder = "닉네임을 입력하세요"
        }
        
        //2. 버튼
        let confirm = UIAlertAction(title: "확인", style: .default) { action in
            guard let nickname = altert.textFields?[0].text else { return }
            
            //공백 검증
            if !self.isOnlyWhitespace(text: nickname) {
                self.saveToUserDefaults(height: height, weight: weight, nickname: nickname)
                self.nicknameLabel.text = "닉네임 : \(nickname)"
            }
        }
        
        //3. 액션 버튼 붙이기
        altert.addAction(confirm)
        //4. 얼럿 띄워주기
        present(altert, animated: true)
    }
    
    private func isOnlyWhitespace(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
