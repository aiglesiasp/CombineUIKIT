//
//  ViewController.swift
//  CombineUIKit
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //BOTON
    @IBAction func loadData(_ sender: Any) {
        //cargamos el tableViewController
        self.navigationController?.pushViewController(TableViewControllerBoots(), animated: true)
    }
}

