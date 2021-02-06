//
//  TableViewController.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let foodsData = SectionModelFood()
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Food>>!
    
    let disposeDag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Food>>(
            configureCell: { dataSource, tableView, indexPath, food in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = food.name
                cell.detailTextLabel?.text = food.flickrID
                cell.imageView?.image = food.image
                return cell
            }, titleForHeaderInSection: { (dataSource, section) -> String? in
                return dataSource.sectionModels[section].identity
            })

        foodsData.foods.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeDag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeDag)
    }
}

///ONLY SWIFT
//extension TableViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foods.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let food = foods[indexPath.row]
//        cell.textLabel?.text = food.name
//        cell.detailTextLabel?.text = food.flickrID
//        cell.imageView?.image = food.image
//        return cell
//    }
//}
//
extension TableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row)")
    }
}
