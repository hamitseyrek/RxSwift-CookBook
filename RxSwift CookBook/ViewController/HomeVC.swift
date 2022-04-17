//
//  HomeVC.swift
//  RxSwift-CookBook
//
//  Created by Hamit Seyrek on 16.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeVC: UIViewController {
    
    var tableViewItems = BehaviorRelay.init(value: [Food.init(name: "Hamburger", image: "swiftUI"),
                                                    Food.init (name: "Pizza", image: "swiftUI"),
                                                    Food.init(name: "Salmon", image: "swiftUI"),
                                                    Food.init(name: "Spaghetti", image: "swiftUI")])
    
    var tableViewItemSection = BehaviorRelay.init(value: [
        SectionModel(header: "Main Section", items: [Food.init(name: "Hamburger", image: "swiftUI"),
                                                     Food.init (name: "Pizza", image: "swiftUI"),
                                                     Food.init(name: "Salmon", image: "swiftUI"),
                                                     Food.init(name: "Spaghetti", image: "swiftUI")]),
        
        SectionModel(header: "Second Section", items: [Food.init(name: "Hamburger", image: "swiftUI"),
                                                       Food.init (name: "Pizza", image: "swiftUI"),
                                                       Food.init(name: "Salmon", image: "swiftUI"),
                                                       Food.init(name: "Spaghetti", image: "swiftUI"),
                                                       Food.init(name: "Hamburger", image: "swiftUI"),
                                                       Food.init (name: "Pizza", image: "swiftUI"),
                                                       Food.init(name: "Salmon", image: "swiftUI"),
                                                       Food.init(name: "Spaghetti", image: "swiftUI")])
    ])
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // season 3 for RxDataSource
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: {  ds, tv, ip, item in
        let cell: FoodTableViewCell = tv.dequeueReusableCell(withIdentifier: "myCell", for: ip) as! FoodTableViewCell
        cell.foodImageView.image = UIImage.init(named: item.image)
        cell.foodLabel.text = item.name
        
        return cell
    }, titleForHeaderInSection:  { ds, index in
        return ds.sectionModels[index].header
    })
    
    override func viewDidLoad() {
        //print("selam")
        super.viewDidLoad()        
        
        _ = searchBar.rx.text.orEmpty
            .throttle(.milliseconds (300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ query in
                self.tableViewItemSection.value.map {
                    sectionModel in
                    SectionModel(header: sectionModel.header, items: sectionModel.items.filter({
                        food in
                        query.isEmpty || food.name.lowercased().contains (query.lowercased())
                    }))
                }
            }
            .bind(to:tableView
                .rx
                .items (dataSource: dataSource))
            .disposed (by: disposeBag)
        
        tableView
            .rx.modelSelected (Food.self)
            .subscribe(onNext: {
                foodObject in
                let foodVC = self.storyboard?.instantiateViewController(identifier: "FoodVC") as! DetailVC
                //1 season
                //foodVC.imageName = foodObject.image
                foodVC.food.accept(foodObject)
                self.navigationController?.pushViewController(foodVC, animated: true)
            })
            .disposed (by: disposeBag)
        
    }
    
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let detailVC = self.storyboard?.instantiateViewController(identifier: "toDetailSegue") as! DetailVC
     //detailVC.imageName = "hamburger"
     self.navigationController?.pushViewController(detailVC, animated: true)
     }
     */
}
