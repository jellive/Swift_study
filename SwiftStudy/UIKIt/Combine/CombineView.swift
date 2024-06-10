//
//  CombineView.swift
//  SwiftStudy
//
//  Created by YooHG on 6/22/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI


struct CombineView<Page: View>: View {
    var viewController: UIHostingController<Page>
    @State var hello: String = "hello"
    
    init (view: Page) {
        self.viewController =
            UIHostingController(rootView: view )
    }
    
    var body: some View {
        CombineViewController(text: $hello)
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView(view: CombineTextView(hello: "hello"))
    }
}
