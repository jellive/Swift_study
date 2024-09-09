//
//  ViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2017. 3. 15..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var menuArray : NSArray = []
    var swiftUIArray: Array<String> = []
    
    private func makeCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self.createSection(for: sectionIndex)
        }
        mainCollectionView.collectionViewLayout = layout
        registerCells()
    }
    
    private func registerCells() {
        self.mainCollectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        default: return createSingleColumnSection()
        }
    }
    
    private func createTwoColumnSection(weightConstant :Int) -> NSCollectionLayoutSection {
        let weight = (Double(weightConstant) * 0.05)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(0.98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1 + weight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15.0
        
        return section
    }
    
    private func createSingleColumnSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuArray = NSArray.init(objects: "구구단", "realm", "IBDesignable", "Drawing", "Category",  "Landmark list", "Local Push",
                                 
                                 "RxMoya-Github", "RxAlamofire-Github", "RxSwift", "Camera", "KingFisher", "ReactorKit-counter", "FastCampus", "UIKit",
                                 "Shape", "ReadText", "ReactorKit-Network", "Compositional Layout", "CLHeaderFooter", "Compositional Netflix")
        swiftUIArray = ["SwiftUI", "SwiftUI-localpush", "SwiftUI-JSONParse", "SwiftUI-ObservableObject"
                        //                        , "SwiftUI-RxAlamofire"
        ]
        
        makeCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? menuArray.count : swiftUIArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        cell.setTitleLabel(text: indexPath.section == 0 ? (menuArray.object(at: indexPath.row) as! String) : (swiftUIArray[indexPath.row]))
//        let label : UILabel = mainCollectionViewCell.viewWithTag(2) as! UILabel;
//        label.text = (menuArray.object(at: indexPath.row) as! String);
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                let vc : GugudanViewController = self.storyboard?.instantiateViewController(withIdentifier: "gugudan") as! GugudanViewController;
                self.present(vc, animated: true, completion: nil);
                break;
            case 1:
                let vc : RealmMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "realm_menu") as! RealmMenuViewController;
                self.present(vc, animated: true, completion: nil);
            case 2:
                let vc : IBDesignableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ib_designable") as! IBDesignableViewController
                self.present(vc, animated: true, completion: nil)
            case 3:
                let vc : DrawingViewController = self.storyboard?.instantiateViewController(withIdentifier: "drawing") as! DrawingViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            case 4:
                let vc : CategoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "category") as! CategoryViewController
                self.present(vc, animated: true, completion: nil)
            case 5:
                let vc = UIHostingController(rootView: LandmarkList().environmentObject(UserData()))
                self.present(vc, animated: true, completion: nil)
            case 6:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "localpush") as! LocalPushViewController
                self.present(vc, animated: true, completion: nil)
            case 7:
                let vc = UIHostingController(rootView: RxAlamofireView())
                present(vc, animated: true){}
            case 8:
                let vc = self.storyboard?.instantiateViewController(identifier: "rxmoya_github") as! RxMoyaGithubViewController
                present(vc, animated: true){}
            case 9:
                guard let vc = self.storyboard?.instantiateViewController(identifier: "rxalamofire_github") as? RxAlamoFireGithubViewController else {
                    return
                }
                present(vc, animated: true){}
            case 10:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxswift") as! RxSwiftViewController
                present(vc, animated: true){}
            case 11:
                let vc = self.storyboard?.instantiateViewController(identifier: "camera") as! CameraViewController
                present(vc, animated: true){}
            case 12:
                let vc = self.storyboard?.instantiateViewController(identifier: "kingfisher") as! KingFisherViewController
                present(vc, animated: true){}
            case 13:
                let vc = self.storyboard?.instantiateViewController(identifier: "reactorkitcounter") as! ReactorKitCounterViewController
                let reactor = ReactorKitCounterViewReactor()
                vc.reactor = reactor
                present(vc, animated: true){}
            case 14:
                let vc = self.storyboard?.instantiateViewController(identifier: "fc_main") as! FCViewController
                present(vc, animated: true){}
                
            case 15:
                let vc = self.storyboard?.instantiateViewController(identifier: "uikit_popup") as! UIKitPopupViewController
                present(vc, animated: true){}
            case 16:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "shape") as! ShapeViewContrller
                present(vc, animated: true)
            case 17:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "readtext") as! ReadTextViewController
                present(vc, animated: true)
            case 18:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "reactorkitnetwork") as! ReactorKitNetworkViewController
                present(vc, animated: true)
            case 19:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "compositional_first") as! CompositionalLayoutFirstViewController
                present(vc, animated: true)
            case 20:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "compositional_headerfooter") as! CompositionalLayoutSupplementaryViewHeaderFooterViewController
                present(vc, animated: true)
            case 21:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "compositional_netflix") as! CompositionalLayoutNetflixViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            default:
                return;
            }
        } else if indexPath.section == 1 {
            
            switch indexPath.row {
            case 0:
                let vc = UIHostingController(rootView: SwiftUIView(viewModel: SwiftUIViewModel()))
                self.present(vc, animated: true, completion: nil)
            case 1:
                let vc = UIHostingController(rootView: SwiftUILocalPushView())
                self.present(vc, animated: true ){}
            case 2:
                let vc = UIHostingController(rootView: SwiftUIJSONParseView())
                present(vc, animated: true, completion: nil)
            case 3:
                let vc = UIHostingController(rootView: SwiftUIObservableObjectView())
                present(vc, animated: true){}
            default:
                return;
            }
        }
    }
    
    
}

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "mainCell"
    private var titleLabel = PaddingLabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutBackground()
    }
    
    func setTitleLabel(text:String) {
        titleLabel.text = text
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 3
        titleLabel.leftPadding = 8
    }
    
    private func layoutBackground() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = contentView.frame.size.height / 2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(gray: 1, alpha: 1)
    }
    
    private func layoutTitleLabel() {
        if !contentView.subviews.contains(titleLabel) {
            contentView.addSubview(titleLabel)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor),
                titleLabel.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor)
                
            ]
        )
    }
}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topPadding: CGFloat = 0.0
    @IBInspectable var leftPadding: CGFloat = 0.0
    @IBInspectable var bottomPadding: CGFloat = 0.0
    @IBInspectable var rightPadding: CGFloat = 0.0
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.topPadding = padding.top
        self.leftPadding = padding.left
        self.bottomPadding = padding.bottom
        self.rightPadding = padding.right
    }
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets.init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += self.leftPadding + self.rightPadding
        contentSize.height += self.topPadding + self.bottomPadding
        return contentSize
    }
    
}

