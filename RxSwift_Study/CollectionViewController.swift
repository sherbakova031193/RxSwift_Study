//
//  CollectionViewController.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    @IBOutlet var longPressGR: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>!
    
    var data = BehaviorRelay(value: [AnimatedSectionModel(title: "Section 0", data: ["0-0"])])
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>(configureCell: { _, collectionView, indexPath, title in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
             cell.label.text = title
             return cell
        }, configureSupplementaryView: { _, collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CollectionReusableView
            header.titleLabel.text = "Section: \(indexPath.section)"
            return header
        }, canMoveItemAtIndexPath: { _, _ in true })
        
        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        addButtonItem.rx.tap.asDriver().drive(onNext: {
            let section = self.data.value.count
            let items: [String] = {
                var items = [String]()
                let random = arc4random_uniform(5) + 1
                (0...random).forEach {
                    items.append("\(section)-\($0)")
                }
                return items
            }()
            var value = self.data.value
            value.append(AnimatedSectionModel(title: "Section: \(section)", data: items))
            self.data.accept(value)
            
        }).disposed(by: disposeBag)
        
        longPressGR.rx.event.subscribe(onNext: {
            switch $0.state {
        
            case .began:
                guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else {
                    break
                }
                self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                
            case .changed:
                self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: self.collectionView))
                
            case .ended:
                self.collectionView.endInteractiveMovement()
    
            default:
                self.collectionView.cancelInteractiveMovement()
                
            }
        }).disposed(by: disposeBag)

    }
}
