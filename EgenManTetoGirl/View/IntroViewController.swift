//
//  IntroViewController.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/31/25.
//

import UIKit

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
