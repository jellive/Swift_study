//
//  ContentView.swift
//  SwiftStudy
//
//  Created by YooHG on 6/18/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

//여성: 655 + (9.6 x 체중(kg)) + (1.8 x 신장(cm)) -(4.7 x 나이)
//남성: 66 + (13.7 x 체중(kg)) + (5 x 신장(cm)) -(6.5 x 나이)


//주로 좌식 생활을 하는 사람: BMR x 1.2
//약간 활동적인 사람 (주당 1일~3일 운동): BMR x 1.3
//보통 (주당 3일~5일 이상 운동): BMR x 1.5
//상당히 활동적인 사람 (매일 운동): BMR x 1.7
//매우 활동적(운동선수와 비슷한 강도로 매일 운동): BMR x 1.9

struct SwiftUIView: View {
    @ObservedObject var viewModel: SwiftUIViewModel
    @State var touchedCount = 0
    @State var name = "0"
    let genderArr = ["남성", "여성", "무언가"]
    
    let actArr = [(key: "거의 안해요", value: 1.2), (key: "1~3일", value: 1.3), (key: "3~5일", value: 1.5), (key: "매일", value: 1.7), (key: "격하게 매일", value: 1.9)]
    @State var selectedAct = 0
    
    @State var act: Double = 0.0
    
    init(viewModel: SwiftUIViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("칼로리 계산")) {
                    TextField("이름을 입력해주세요", text: $viewModel.name)
                    Picker(selection: $viewModel.gender, label: Text("성별")) {
                        ForEach(0 ..< genderArr.count) {
                            Text(self.genderArr[$0])
                        }
                    }
                    TextField("신장을 입력해주세요", value: $viewModel.height, formatter: NumberFormatter()).keyboardType(.numberPad)
                    TextField("체중을 입력해주세요", value: $viewModel.weight, formatter: NumberFormatter()).keyboardType(.numberPad)
                    TextField("나이를 입력해주세요", value: $viewModel.age, formatter: NumberFormatter()).keyboardType(.numberPad)
                    Picker(selection: $selectedAct, label: Text("일주일에 운동을 어느정도 하시나요?")) {
                        ForEach(0 ..< actArr.count) {
                            Text(self.actArr[$0].key)
                        }
                    }
                    Text("\(actArr[selectedAct].value)")
                    Text("\(viewModel.act)")
                    NavigationLink(destination: SecondSwiftUIView(touchedCount: $viewModel.act)) {
                        Text("계산하기")
                    }
                }
                
                Section{
                    Text("버튼을 클릭한 횟수 \(touchedCount)")
                    Button("this is a Button") {
                        self.touchedCount += 1
                    }
                }
                HStack {
                    Image(systemName: "goforward.90")
                    NavigationLink(destination: SecondSwiftUIView(touchedCount: self.$touchedCount)) {
                        Text("다음꺼")
                    }
                }
                Section(header: Text("이름")){
                    TextField("이름을 입력해주세요", text: $name)
                }
                
                Section(header: Text("나이")){
                    TextField("나이를 입력해주세요", value: $viewModel.age, formatter: NumberFormatter()).keyboardType(.numberPad)
                }
                
                Section(header: Text("결과")){
                    Text("\(name)님의 나이는 \(viewModel.age)살입니다.")
                }
                
//                Group {
//                    Text("hi?")
//                    Text("hi?")
//                    Text("hi?")
//                    Text("hi?")
//                    Text("hi?")
//                }
            }.navigationBarTitle("this is title")
        }.onAppear {
            print("view appeared")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(viewModel: SwiftUIViewModel())
    }
}
