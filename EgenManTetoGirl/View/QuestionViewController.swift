//
//  ViewController.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 6/26/25.
//

import UIKit

class QuestionViewController: UIViewController {
    let gender: Gender
    var questions: [Question]
    var currentIndex = 0
    var answers: [(Question, AnswerScore)] = []

    private let questionLabel = UILabel()
    private let stackView = UIStackView()
    private let progressView = UIProgressView()
    private let progressLabel = UILabel()

    init(gender: Gender) {
        self.gender = gender
        self.questions = QuestionProvider.questions(for: gender)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 흰색 기본 배경

        // 성별에 따라 그라데이션 레이어 추가
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        if gender == .male {
            gradientLayer.colors = [
                UIColor.systemBlue.withAlphaComponent(0.5).cgColor,
                UIColor.white.withAlphaComponent(0.0).cgColor
            ]
        } else {
            gradientLayer.colors = [
                UIColor.systemPink.withAlphaComponent(0.5).cgColor,
                UIColor.white.withAlphaComponent(0.0).cgColor
            ]
        }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.5, y: 1.5)
        view.layer.insertSublayer(gradientLayer, at: 0)

        // 프로그레스 뷰 설정
        progressView.progressTintColor = gender == .male ? .systemBlue : .systemPink
        progressView.trackTintColor = UIColor.systemGray5
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true

        // 프로그레스 라벨 설정
        progressLabel.textAlignment = .center
        progressLabel.font = .systemFont(ofSize: 14)
        progressLabel.textColor = .darkText

        questionLabel.font = .systemFont(ofSize: 20)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.textColor = .darkText

        stackView.axis = .vertical
        stackView.spacing = 16
        ["매우 그렇다", "그렇다", "그렇지 않다", "매우 그렇지 않다"].enumerated().forEach { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = index
            
            // 모던한 버튼 디자인
            let mainColor = gender == .male ? UIColor.systemBlue : UIColor.systemPink
            button.backgroundColor = mainColor
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 0
            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
            
            // 그림자 효과
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.1
            
            // 터치 효과
            button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }

        [progressView, progressLabel, questionLabel, stackView].forEach { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 8),

            progressLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 8),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -180),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

//            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 60),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        AdManager.shared.loadInterstitialAd()
        showQuestion()
    }

    func showQuestion() {
        guard currentIndex < questions.count else {
            // 마지막 답변 후 광고 표시
            AdManager.shared.showInterstitialAd(from: self) { [weak self] in
                self?.showResult()
            }
            return
        }
        
        // 페이드 아웃 애니메이션
        UIView.animate(withDuration: 0.1, animations: {
            self.questionLabel.alpha = 0
            self.stackView.alpha = 0
            self.progressLabel.alpha = 0
        }) { _ in
            // 데이터 갱신
            let progress = Float(self.currentIndex) / Float(self.questions.count)
            self.progressView.setProgress(progress, animated: true)
            self.progressLabel.text = "\(self.currentIndex) / \(self.questions.count)"
            self.questionLabel.text = self.questions[self.currentIndex].text

            // 페이드 인 애니메이션
            UIView.animate(withDuration: 0.1) {
                self.questionLabel.alpha = 1
                self.stackView.alpha = 1
                self.progressLabel.alpha = 1
            }
        }
    }

    func showResult() {
        let (resultType, resultDesc, tettoPercent, egenPercent, tettoScore, egenScore) = ResultCalculator.calculate(answers: answers, gender: gender)
        let resultVC = ResultViewController(resultType: resultType, description: resultDesc, tettoPercent: tettoPercent, egenPercent: egenPercent, tettoScore: tettoScore, egenScore: egenScore)
        navigationController?.pushViewController(resultVC, animated: true)
    }

    @objc func answerTapped(_ sender: UIButton) {
        let scores: [AnswerScore] = [.veryAgree, .agree, .disagree, .veryDisagree]
        let answer = scores[sender.tag]
        answers.append((questions[currentIndex], answer))
        currentIndex += 1
        showQuestion()
    }

    @objc private func buttonTouchUp(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }
    
    
}
