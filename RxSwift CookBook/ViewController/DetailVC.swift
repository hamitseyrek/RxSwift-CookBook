//
//  DetailVC.swift
//  RxSwift CookBook
//
//  Created by Hamit Seyrek on 17.04.2022.
//

import UIKit
import RxRelay
import RxSwift

class DetailVC: UIViewController {
    
    @IBOutlet weak var foodDetailLabel: UILabel!
    @IBOutlet weak var foodDetailImage: UIImageView!
    
    //1 season
    //var imageName = ""
    
    let food = BehaviorRelay<Food>(value: Food(name: "", image: ""))
    let disposeBag2 = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1 season
        //foodDetailImage.image = UIImage(named: imageName)
        
        food
            .map { elem in
                UIImage(named: elem.image)
            }
            .bind(to: foodDetailImage
                .rx
                .image
            )
            .disposed(by: disposeBag2)
        
        food
            .map { elem in
                elem.name
            }
            .bind(to: foodDetailLabel
                .rx
                .text
            )
            .disposed(by: disposeBag2)
    }
}
