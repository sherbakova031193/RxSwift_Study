//
//  TableViewController.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let foods = Observable.just([
        Food(name: "Колбаски", flickrID: "1"),
        Food(name: "Блинчики", flickrID: "2"),
        Food(name: "Суши", flickrID: "3"),
        Food(name: "Пицца", flickrID: "4"),
        Food(name: "Гамбургеры", flickrID: "5"),
        Food(name: "Ягоды", flickrID: "6"),
        Food(name: "Салат", flickrID: "7"),
        Food(name: "Бекон", flickrID: "8"),
        Food(name: "Нарезка", flickrID: "9"),
        Food(name: "Зеленый салат", flickrID: "10"),
        Food(name: "Греческий салат", flickrID: "11"),
        Food(name: "Фастфуд", flickrID: "12"),
        Food(name: "Фастфуд 2", flickrID: "13"),
        Food(name: "Дисерт", flickrID: "14"),
        Food(name: "Завтрак", flickrID: "15"),
        Food(name: "Мюсли", flickrID: "16"),
        Food(name: "Я не знаю что это", flickrID: "17"),
        Food(name: "Виноград", flickrID: "18"),
        Food(name: "Сыр", flickrID: "19"),
        Food(name: "Еще блинчики", flickrID: "20"),
    ])
    
    let disposeDag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, food, cell in
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.flickrID
            cell.imageView?.image = food.image
        }.disposed(by: disposeDag)

        tableView.rx.modelSelected(Food.self).subscribe {
            print("You selected \($0)")
        }.disposed(by: disposeDag)
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
//extension TableViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("Selected row \(indexPath.row)")
//    }
//}
