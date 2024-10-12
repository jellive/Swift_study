import SwiftUI
//import ComposableArchitecture
import SwiftData

public struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State var name: String = ""
    @State var description: String = ""
    @State private var alertIsShowing: Bool = false
    @State private var alertItem: AlertItem?
    
    
    public var body: some View {
        VStack {
            TextField("Enter day", text: $name, axis: .vertical)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .onSubmit {
                    access()
                }
            Spacer()
            TextField("\(description)", text: $description, axis: .vertical)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .onSubmit {
                    access()
                }
        }
        .alert(alertItem?.title ?? "Alert", isPresented: $alertIsShowing, presenting: alertItem) { item in
            Button( role: .cancel) {
                description = ""
            } label: {
                Text("Cancel")
            }
        }
    }
    func access() {
        if name.isEmpty {
            //            alertItem = AlertItem(title: "제목이 없음")
            //            alertIsShowing = true
            //        }
            //        
            //        print("desc: \(String(describing: viewModel.getUserDefaults(name)))")
            //
            //        if let desc = viewModel.getUserDefaults(name) {
            //            description = desc
            //        } else {
            //            if description.isEmpty {
            //                alertItem = AlertItem(title: "저장하려는데 desc가 없음!")
            //                alertIsShowing = true
            //                return
            //            }
            //            viewModel.setUserDefaults(name: description, key: name)
            //
            //            alertItem = AlertItem(title: "저장됨!")
            //            alertIsShowing = true
            //        }
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
