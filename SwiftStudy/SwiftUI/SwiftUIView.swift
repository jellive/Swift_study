//
//  ContentView.swift
//  SwiftStudy
//
//  Created by YooHG on 6/18/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State var touchedCount = 0
    @State var name = ""
    @State var age = ""
    var body: some View {
        NavigationView {
            Form {
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
                    TextField("나이를 입력해주세요", text: $age).keyboardType(.numberPad)
                }
                
                Section(header: Text("결과")){
                    Text("\(name)님의 나이는 \(age)살입니다.")
                }
                
                Group {
                    Text("hi?")
                    Text("hi?")
                    Text("hi?")
                    Text("hi?")
                    Text("hi?")
                }
            }.navigationBarTitle("this is title")
        }.onAppear {
            print("view appeared")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
