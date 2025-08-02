//
//  ResultCalculator.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/30/25.
//

import Foundation

struct ResultCalculator {
    static func calculate(answers: [(Question, AnswerScore)], gender: Gender) -> (String, String, String, Int, Int, Int, Int) {
        let tettoScore = answers.filter { $0.0.trait == .tetto }.map { $0.1.rawValue }.reduce(0, +)
        let egenScore = answers.filter { $0.0.trait == .egen }.map { $0.1.rawValue }.reduce(0, +)
        
        // 최대 점수 계산 (각 질문당 최대 2점, 최소 -2점)
        let maxTettoScore = answers.filter { $0.0.trait == .tetto }.count * 2
        let maxEgenScore = answers.filter { $0.0.trait == .egen }.count * 2
        
        // 퍼센트 계산 (0-100 범위로 정규화)
        let tettoPercent: Int
        if maxTettoScore > 0 {
            // 최소 점수: -maxTettoScore, 최대 점수: maxTettoScore
            // 0-100 범위로 정규화
            let normalizedTettoScore = Double(tettoScore + maxTettoScore) / Double(maxTettoScore * 2)
            tettoPercent = Int(normalizedTettoScore * 100)
        } else {
            tettoPercent = 50
        }
        
        let egenPercent: Int
        if maxEgenScore > 0 {
            // 최소 점수: -maxEgenScore, 최대 점수: maxEgenScore
            // 0-100 범위로 정규화
            let normalizedEgenScore = Double(egenScore + maxEgenScore) / Double(maxEgenScore * 2)
            egenPercent = Int(normalizedEgenScore * 100)
        } else {
            egenPercent = 50
        }

        let resultType: String
        let resultImage: String
        let tetoMan: [String] = ["테토남", "테토남1", "테토남2", "테토남3", "테토남4"]
        let egenMan: [String] = ["에겐남", "에겐남1", "에겐남2", "에겐남3", "에겐남4"]
        let tetoGirl: [String] = ["테토녀", "테토녀1", "테토녀2", "테토녀3", "테토녀4"]
        let egenGirl: [String] = ["에겐녀", "에겐녀1", "에겐녀2", "에겐녀3", "에겐녀4", "에겐녀5"]
        
        
        
        switch gender {
        case .male:
            if tettoScore >= egenScore {
                resultType = "테토남"
                resultImage = tetoMan.randomElement() ?? "테토남"
            } else {
                resultType = "에겐남"
                resultImage = egenMan.randomElement() ?? "에겐남"
            }
        case .female:
            if tettoScore >= egenScore {
                resultType = "테토녀"
                resultImage = tetoGirl.randomElement() ?? "테토녀"
            } else {
                resultType = "에겐녀"
                resultImage = egenGirl.randomElement() ?? "에겐녀"
            }
        }
        return (resultType, resultImage, ResultDescriptions.description(for: resultType), tettoPercent, egenPercent, tettoScore, egenScore)
    }
}
