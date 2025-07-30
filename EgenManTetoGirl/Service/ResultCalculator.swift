//
//  ResultCalculator.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/30/25.
//

import Foundation

struct ResultCalculator {
    static func calculate(answers: [(Question, AnswerScore)], gender: Gender) -> (String, String, Int, Int, Int, Int) {
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
        switch gender {
        case .male:
            resultType = tettoScore >= egenScore ? "테토남" : "에겐남"
        case .female:
            resultType = tettoScore >= egenScore ? "테토녀" : "에겐녀"
        }
        return (resultType, ResultDescriptions.description(for: resultType), tettoPercent, egenPercent, tettoScore, egenScore)
    }
}
