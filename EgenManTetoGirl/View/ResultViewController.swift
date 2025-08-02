//
//  ResultViewController.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/31/25.
//

import UIKit


enum ButtomType {
    case home, share
}

// MARK: - ResultViewController

class ResultViewController: UIViewController {
    let resultType: String
    let resultImage: String
    let descriptionText: String
    let tettoPercent: Int
    let egenPercent: Int
    let tettoScore: Int
    let egenScore: Int
    private var gradientLayer: CAGradientLayer?

    init(resultType: String, resultImage: String, description: String, tettoPercent: Int, egenPercent: Int, tettoScore: Int, egenScore: Int) {
        self.resultType = resultType
        self.resultImage = resultImage
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
        resultImageView.image = UIImage(named: resultImage)
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

        let homeButton = createButton(type: .home) {
            self.goToRoot()
        }
        
        lazy var shareButton: UIButton = {
            createButton(type: .share) { [weak self] in
                guard let self = self else { return }

                // 제외할 버튼들 (자기 자신 포함)
                let excludedButtons: [UIView] = [shareButton, homeButton]

                // 숨기기
                excludedButtons.forEach { $0.isHidden = true }

                // 이미지 캡처
                let capturedImage = self.view.asImage()

                // 다시 보이게
                excludedButtons.forEach { $0.isHidden = false }

                // 공유 또는 저장
                let activityVC = UIActivityViewController(activityItems: [capturedImage], applicationActivities: nil)
                self.present(activityVC, animated: true)
            }
        }()

        
        let stackView = UIStackView(arrangedSubviews: [homeButton, shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill

        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

            stackView.topAnchor.constraint(equalTo: egenContainer.bottomAnchor, constant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // 버튼 생성
    func createButton(type: ButtomType, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        switch type {
        case .home:
            button.setTitle("처음으로", for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
        case .share:
            let image = UIImage(systemName: "square.and.arrow.up")
            button.setImage(image, for: .normal)
            button.tintColor = .systemBlue
            button.imageView?.contentMode = .scaleAspectFit
//            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true

        }
        

        // 그림자 효과
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.3

        button.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
        
        return button
    }
    
    
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }

    // 첫 페이지로 돌아가기 액션
    private func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension UIView {
    // 뷰를 이미지로 만들어서 반환
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { context in
            self.layer.render(in: context.cgContext)
        }
    }
}
