//
//  DetailViewController.swift
//  CavistaProject
//
//  Created by Sproxil IN on 15/08/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController{
    
    //MARK: - OUTLETS AND PROPERTIES
    
// Create variable for passing data from previous view
    var id:String?
    var type:String?
    var date:String?
    var data:String?
    var cellimage:UIImage?
    
    // Create Label and Text view outlet
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textLabel:UITextView = {
        let label = UITextView()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        viewSetUp()
    }
    
    //MARK: - Functions
    
    func initialSetUp(){
        view.backgroundColor = .white
        title = date
    }
    
    func viewSetUp(){
        view.addSubview(idLabel)
        view.addSubview(typeLabel)
        idLabel.text = "List ID: \(self.id ?? "")"
        typeLabel.text = "Type : \(self.type ?? "")"
        
        // Add constarint through SnapKit
        idLabel.snp.makeConstraints{(make) in
            make.top.equalTo(92)
            make.left.equalTo(8)
            make.right.equalTo(-108)
            make.height.equalTo(20)
        }
        
        typeLabel.snp.makeConstraints{(make) in
            make.top.equalTo(92)
            make.right.equalTo(-8)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        if cellimage != nil{
            view.addSubview(imageView)
            imageView.image = cellimage
            imageView.snp.makeConstraints{(make) in
                make.top.equalTo(120)
                make.right.equalTo(-8)
                make.bottom.equalTo(-8)
                make.left.equalTo(8)
            }
        }else{
            view.addSubview(textLabel)
            textLabel.text = data
            textLabel.snp.makeConstraints{(make) in
                make.top.equalTo(120)
                make.right.equalTo(-8)
                make.bottom.equalTo(-12)
                make.left.equalTo(8)
            }
        }
        
    }
}
