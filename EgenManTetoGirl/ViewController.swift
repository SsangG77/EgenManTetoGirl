//
//  ViewController.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 6/26/25.
//

import UIKit
import GoogleMobileAds

// MARK: - IntroViewController

class IntroViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택하세요"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    private let girlImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "girl")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        // 그림자 적용
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOpacity = 0.3
        
        return imageView
    }()

    private let femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("여자", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        return button
    }()

    private let boyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "boy")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        // 그림자 적용
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOpacity = 0.3
        
        return imageView
    }()

    private let maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("남자", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        return button
    }()

    private var gradientLayer: CAGradientLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 배경색을 흰색으로 설정
        view.backgroundColor = .white
        
        // 그라데이션 배경 적용
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.5).cgColor,
            UIColor.systemPink.withAlphaComponent(0.5).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 그라데이션 레이어 참조 저장
        self.gradientLayer = gradientLayer

        [titleLabel, girlImageView, femaleButton, boyImageView, maleButton].forEach { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // 왼쪽 (여자)
            girlImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            girlImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            girlImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            girlImageView.heightAnchor.constraint(equalTo: girlImageView.widthAnchor, multiplier: 1.5),

            femaleButton.topAnchor.constraint(equalTo: girlImageView.bottomAnchor, constant: 20),
            femaleButton.centerXAnchor.constraint(equalTo: girlImageView.centerXAnchor),

            // 오른쪽 (남자)
            boyImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            boyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boyImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            boyImageView.heightAnchor.constraint(equalTo: boyImageView.widthAnchor, multiplier: 1.5),

            maleButton.topAnchor.constraint(equalTo: boyImageView.bottomAnchor, constant: 20),
            maleButton.centerXAnchor.constraint(equalTo: boyImageView.centerXAnchor)
        ])

        maleButton.addTarget(self, action: #selector(didTapMale), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(didTapFemale), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }

    @objc private func didTapMale() {
        let vc = QuestionViewController(gender: .male)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapFemale() {
        let vc = QuestionViewController(gender: .female)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 광고 관리 전용 클래스

class AdManager: NSObject, FullScreenContentDelegate {
    static let shared = AdManager()
    private override init() {}

    private var interstitial: InterstitialAd?
    private var completion: (() -> Void)?
    
    enum AdType {
        case test, real
    }
    
    func getAdId(_ t: AdType) -> String {
        if t == .real {
            return ProcessInfo.processInfo.environment["ADMOB_ID"] ?? "ca-app-pub-3940256099942544/4411468910"
        } else {
            return "ca-app-pub-3940256099942544/4411468910"
        }
        
    }

    func loadInterstitialAd() {
        let request = Request()
#warning("Ad id")
        // let id = getAdId(.test)
        
        #if DEBUG
        let id = "ca-app-pub-3940256099942544/4411468910"
        #else
        let id = "ca-app-pub-3545555975398754/1374892852"
        #endif
        
        InterstitialAd.load(with: id, request: request) { [weak self] ad, error in
            if let ad = ad {
                self?.interstitial = ad
                ad.fullScreenContentDelegate = self
            } else {
                self?.interstitial = nil
            }
        }
    }

    func showInterstitialAd(from viewController: UIViewController, completion: @escaping () -> Void) {
        if let interstitial = interstitial {
            self.completion = completion
            interstitial.present(from: viewController)
        } else {
            completion()
        }
    }

    // 광고가 닫혔을 때 호출
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        completion?()
        completion = nil
        loadInterstitialAd() // 다음을 위해 미리 로드
    }
}

// MARK: - QuestionViewController

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
//            button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
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

            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 60),
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

// MARK: - ResultViewController

class ResultViewController: UIViewController {
    let resultType: String
    let descriptionText: String
    let tettoPercent: Int
    let egenPercent: Int
    let tettoScore: Int
    let egenScore: Int
    private var gradientLayer: CAGradientLayer?

    init(resultType: String, description: String, tettoPercent: Int, egenPercent: Int, tettoScore: Int, egenScore: Int) {
        self.resultType = resultType
        self.descriptionText = description
        self.tettoPercent = tettoPercent
        self.egenPercent = egenPercent
        self.tettoScore = tettoScore
        self.egenScore = egenScore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 배경색을 흰색으로 설정
        view.backgroundColor = .white
        
        // 뒤로가기 버튼 숨기기
        navigationItem.hidesBackButton = true
        
        // 뒤로가기 제스처 비활성화
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // 그라데이션 배경 적용
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.5).cgColor,
            UIColor.systemPink.withAlphaComponent(0.5).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 그라데이션 레이어 참조 저장
        self.gradientLayer = gradientLayer

        let titleLabel = UILabel()
        titleLabel.text = resultType
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white

        // 결과 이미지뷰 추가
        let resultImageView = UIImageView()
        resultImageView.image = UIImage(named: resultType)
        resultImageView.contentMode = .scaleAspectFit
        resultImageView.layer.cornerRadius = 20
        resultImageView.clipsToBounds = true
        
        // 그림자 효과
        resultImageView.layer.shadowColor = UIColor.black.cgColor
        resultImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultImageView.layer.shadowRadius = 8
        resultImageView.layer.shadowOpacity = 0.3

        let descLabel = UILabel()
        descLabel.text = descriptionText
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.font = .systemFont(ofSize: 18)
        descLabel.textColor = .white

        // 테토 퍼센트 라벨
        let tettoPercentLabel = UILabel()
        tettoPercentLabel.text = "\(tettoPercent)%"
        tettoPercentLabel.textAlignment = .center
        tettoPercentLabel.font = .boldSystemFont(ofSize: 18)
        tettoPercentLabel.textColor = .white

        // 테토 퍼센트 바
        let tettoContainer = UIView()
        tettoContainer.backgroundColor = .systemGray5
        tettoContainer.layer.cornerRadius = 10

        let tettoProgressBar = UIView()
        tettoProgressBar.backgroundColor = .systemBlue
        tettoProgressBar.layer.cornerRadius = 10

        // 에겐 퍼센트 라벨
        let egenPercentLabel = UILabel()
        egenPercentLabel.text = "\(egenPercent)%"
        egenPercentLabel.textAlignment = .center
        egenPercentLabel.font = .boldSystemFont(ofSize: 18)
        egenPercentLabel.textColor = .white

        // 에겐 퍼센트 바
        let egenContainer = UIView()
        egenContainer.backgroundColor = .systemGray5
        egenContainer.layer.cornerRadius = 10

        let egenProgressBar = UIView()
        egenProgressBar.backgroundColor = .systemPink
        egenProgressBar.layer.cornerRadius = 10

        [titleLabel, resultImageView, descLabel, tettoContainer, tettoProgressBar, tettoPercentLabel, egenContainer, egenProgressBar, egenPercentLabel].forEach { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        let homeButton = UIButton(type: .system)
        homeButton.setTitle("처음으로", for: .normal)
        homeButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        homeButton.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        homeButton.setTitleColor(.systemBlue, for: .normal)
        homeButton.layer.cornerRadius = 25
        homeButton.layer.borderWidth = 2
        homeButton.layer.borderColor = UIColor.white.cgColor
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
        
        // 그림자 효과
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        homeButton.layer.shadowRadius = 8
        homeButton.layer.shadowOpacity = 0.3
        
        homeButton.addTarget(self, action: #selector(goToRoot), for: .touchUpInside)
        view.addSubview(homeButton)
        homeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            resultImageView.heightAnchor.constraint(equalTo: resultImageView.widthAnchor, multiplier: 1.5),

            descLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 40),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tettoContainer.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 40),
            tettoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tettoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            tettoContainer.heightAnchor.constraint(equalToConstant: 20),

            tettoProgressBar.topAnchor.constraint(equalTo: tettoContainer.topAnchor),
            tettoProgressBar.leadingAnchor.constraint(equalTo: tettoContainer.leadingAnchor),
            tettoProgressBar.heightAnchor.constraint(equalTo: tettoContainer.heightAnchor),
            tettoProgressBar.widthAnchor.constraint(equalTo: tettoContainer.widthAnchor, multiplier: CGFloat(tettoPercent) / 100.0),

            tettoPercentLabel.centerYAnchor.constraint(equalTo: tettoContainer.centerYAnchor),
            tettoPercentLabel.leadingAnchor.constraint(equalTo: tettoContainer.trailingAnchor, constant: 15),
            tettoPercentLabel.widthAnchor.constraint(equalToConstant: 80),

            egenContainer.topAnchor.constraint(equalTo: tettoContainer.bottomAnchor, constant: 30),
            egenContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            egenContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            egenContainer.heightAnchor.constraint(equalToConstant: 20),

            egenProgressBar.topAnchor.constraint(equalTo: egenContainer.topAnchor),
            egenProgressBar.leadingAnchor.constraint(equalTo: egenContainer.leadingAnchor),
            egenProgressBar.heightAnchor.constraint(equalTo: egenContainer.heightAnchor),
            egenProgressBar.widthAnchor.constraint(equalTo: egenContainer.widthAnchor, multiplier: CGFloat(egenPercent) / 100.0),

            egenPercentLabel.centerYAnchor.constraint(equalTo: egenContainer.centerYAnchor),
            egenPercentLabel.leadingAnchor.constraint(equalTo: egenContainer.trailingAnchor, constant: 15),
            egenPercentLabel.widthAnchor.constraint(equalToConstant: 80),

            homeButton.topAnchor.constraint(equalTo: egenContainer.bottomAnchor, constant: 40),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }

    @objc private func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
