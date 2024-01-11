//
//  CompositionalLayoutNetflixViewController.swift
//  SwiftStudy
//
//  Created by HGYoo on 1/9/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import UIKit
import SwiftUI

class CompositionalLayoutNetflixViewController: UICollectionViewController {
    
    var contents: [CompositionalNetflixContent] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix_icon") , style: .plain, target: nil, action: #selector(self.backClicked(_ :))) // netflix icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        // Data 설정, 가져오기
        contents = getContents()
        
        // CollectionView Item(Cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
        
    }
    
    @objc func backClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func getContents() -> [CompositionalNetflixContent] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([CompositionalNetflixContent].self,  from: data ) else {return []}
        return list
    }
}

//UICollectionView DataSource, Delegate
extension CompositionalLayoutNetflixViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell.init() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        default:
            
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell.init() }
                cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
                return cell
//            return UICollectionViewCell.init()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header")}
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("item: \(sectionName) section, \(indexPath.row + 1)'th content")
    }
}

// SwiftUI preview with UIKIt
@available(iOS 13.0.0, *)
struct CompositionLayoutNetflixViewController_preview: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
//    #Preview {
//        Container()
//    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let netflixVC = CompositionalLayoutNetflixViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: netflixVC)
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}
