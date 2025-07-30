//
//  QuestionProvider.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/30/25.
//

import Foundation

struct QuestionProvider {
    static func questions(for gender: Gender) -> [Question] {
        if gender == .male {
            return maleQuestions
        } else {
            return femaleQuestions
        }
    }

    static let maleQuestions: [Question] = [
            Question(id: 1, text: "옷을 입을 때 다양한 스타일을 구현하기 위해 노력하시나요?", trait: .egen),
            Question(id: 2, text: "스트레스를 받을 때 감정에 휘둘리기보다는 해결 방법을 먼저 찾으시나요?", trait: .tetto),
            Question(id: 3, text: "모임에서 먼저 분위기를 이끄는 편인가요?", trait: .tetto),
            Question(id: 4, text: "성공은 눈에 보이는 결과라고 생각하시나요?", trait: .tetto),
            Question(id: 5, text: "쇼핑할 때 무난한 브랜드를 선호하시나요?", trait: .tetto),
            Question(id: 6, text: "친구의 고민에 공감하며 위로하는 것이 자연스럽나요?", trait: .egen),
            Question(id: 7, text: "힘들 때 친구에게 감정을 공유하나요?", trait: .egen),
            Question(id: 8, text: "새로운 도전에 있어 실패에 대한 불안이 큰가요?", trait: .egen),
            Question(id: 9, text: "목표를 끝까지 밀어붙이는 편인가요?", trait: .tetto),
            Question(id: 10, text: "외모에 대한 칭찬이 자신감에 큰 영향을 주나요?", trait: .egen),
            Question(id: 11, text: "비판을 들으면 감정보다 분석부터 하나요?", trait: .tetto),
            Question(id: 12, text: "사람과의 관계에서 감정보다 논리를 우선시하나요?", trait: .tetto),
            Question(id: 13, text: "사회적 성공에 대한 부담을 느끼시나요?", trait: .tetto),
            Question(id: 14, text: "처음 보는 사람에게 편하게 다가가려 노력하나요?", trait: .egen),
            Question(id: 15, text: "깔끔하고 단순한 스타일을 선호하시나요?", trait: .tetto),
            Question(id: 16, text: "서운한 감정을 구체적으로 설명하는 편인가요?", trait: .tetto),
            Question(id: 17, text: "감동적인 영화나 음악에 쉽게 울컥하나요?", trait: .egen),
            Question(id: 18, text: "과거 감정보다는 현재에 집중하려 하나요?", trait: .tetto),
            Question(id: 19, text: "트렌디한 브랜드나 스타일을 탐색하는 걸 즐기시나요?", trait: .egen),
            Question(id: 20, text: "타인의 아픔에 깊은 감정 이입을 하시나요?", trait: .egen)
        ]

    static let femaleQuestions: [Question] = [
            Question(id: 1, text: "패션 스타일을 바꾸는 것을 즐기시나요?", trait: .egen),
            Question(id: 2, text: "문제가 생기면 먼저 감정을 다스리고 차분하게 해결책을 찾으시나요?", trait: .tetto),
            Question(id: 3, text: "모임에서 자연스럽게 대화를 주도하는 편인가요?", trait: .tetto),
            Question(id: 4, text: "성공을 사회적 인정이나 성취로 판단하시나요?", trait: .tetto),
            Question(id: 5, text: "평소 쇼핑할 때 무난하고 기본적인 브랜드를 선호하시나요?", trait: .tetto),
            Question(id: 6, text: "친구가 어려움을 겪을 때 깊이 공감하고 위로하는 편인가요?", trait: .egen),
            Question(id: 7, text: "힘들 때 주로 가까운 사람과 감정을 나누시나요?", trait: .egen),
            Question(id: 8, text: "새로운 도전을 할 때 실패 걱정이 먼저 드나요?", trait: .egen),
            Question(id: 9, text: "한번 세운 목표를 끝까지 밀어붙이는 편인가요?", trait: .tetto),
            Question(id: 10, text: "외모에 대해 칭찬을 받으면 자신감이 생기나요?", trait: .egen),
            Question(id: 11, text: "비판을 받을 때 감정보다는 내용을 분석하려고 하나요?", trait: .tetto),
            Question(id: 12, text: "관계에서 논리적 판단을 더 중요하게 생각하시나요?", trait: .tetto),
            Question(id: 13, text: "사회적 성공에 대해 부담감을 느끼는 편인가요?", trait: .tetto),
            Question(id: 14, text: "처음 만나는 사람에게 편안하게 다가가려고 노력하나요?", trait: .egen),
            Question(id: 15, text: "깔끔하고 단순한 스타일을 선호하시나요?", trait: .tetto),
            Question(id: 16, text: "서운한 감정을 상대에게 솔직히 표현하나요?", trait: .egen),
            Question(id: 17, text: "감성적인 영화나 음악에 쉽게 감동받나요?", trait: .egen),
            Question(id: 18, text: "과거 일에 오래 머무르기보다 빨리 털어내나요?", trait: .tetto),
            Question(id: 19, text: "유니크하고 트렌디한 스타일을 즐겨 찾나요?", trait: .egen),
            Question(id: 20, text: "다른 사람의 어려움에 깊게 공감하나요?", trait: .egen)
        ]

}
