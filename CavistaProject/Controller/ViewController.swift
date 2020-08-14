import UIKit
import Alamofire
import Kingfisher
import RealmSwift
import Unrealm
import SnapKit
class ViewController: UICollectionViewController{
    
    //MARK: -  Properties and Global Variables
    //Initializers
    var dataListArray:[dataItem] = []
    let cellId = "cell"
    let realm = try! Realm() // Initialize Realm object
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .gray // View not load from storyboard, so to use remove black screen
        collectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        navigationItem.title = "List"
        
        //printing realm database address
       print("Realm path: ",Realm.Configuration.defaultConfiguration.fileURL!)
        checkDataInDatabseOrNot()
    }
    
    
    //MARK: - Collection View Delegates methods
    
    /* Collection view Delegates methods start*/
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataListArray.count  // Cell count is Total count of main array
    }
    
    // Use to bind data on cell to indexpath from main array
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DataCollectionViewCell
        let currentCellData = dataListArray[indexPath.row]
        cell.idLabel.text = currentCellData.id
        cell.dateLabel.text = currentCellData.date
        if currentCellData.type == "image"{  // checking for image
            let imageLinkContains = loadImageView.urlFromString(text: currentCellData.data)
            if imageLinkContains != ""{  // Image Link
                cell.textLabel.isHidden = true
                cell.imageView.isHidden = false
                let image = UIImage(named: "no-image-available")
                let url = URL(string: currentCellData.data)
                cell.imageView.kf.setImage(with:url, placeholder: image)
            }else{
                cell.imageView.isHidden = true
                cell.textLabel.isHidden = false
                cell.textLabel.text = currentCellData.data.replacingOccurrences(of: "\n", with: "")
            }
            
        }else{
            let imageLinkContains = loadImageView.urlFromString(text: currentCellData.data)
            if imageLinkContains != ""{
                cell.textLabel.isHidden = true
                cell.imageView.isHidden = false
                
                let image = UIImage(named: "no-image-available")
                let url = URL(string: currentCellData.data)
                cell.imageView.kf.setImage(with:url, placeholder: image)
            }else{
                cell.imageView.isHidden = true
                cell.textLabel.isHidden = false
                cell.textLabel.text = currentCellData.data.replacingOccurrences(of: "\n", with: "")
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DataCollectionViewCell
        let dataAtIndex = dataListArray[indexPath.row]
        let VC = DetailViewController()
        VC.id = cell.idLabel.text
        VC.type = dataAtIndex.type
        VC.date = cell.dateLabel.text
        VC.data = cell.textLabel.text
        VC.cellimage = cell.imageView.image
        self.navigationController?.pushViewController(VC, animated: true)
    }
    /* Collection view Delegates methods End*/
    
    //MARK: - Global Functions
    func checkDataInDatabseOrNot(){
        let results = self.realm.objects(dataItem.self)
        if results.count > 0{ // Data is in Databse
            for result in results{
                self.dataListArray.append(result)
            }
            sortArrayAndReloadCollection()
        }else{ // call Api
           listData()
        }
    }
    
    func sortArrayAndReloadCollection(){
        dataListArray = dataListArray.sorted(by: { $0.type < $1.type })
        self.collectionView.reloadData()
    }
    
    // Call Api for Data
    func listData(){
        let urlPath = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch(response.result) {
                
            case .success(_):
                guard let json = response.result.value as! [[String:String]]? else{ return}
                
                var variableForPrimaryKey = 0
                
                for item in json{
                    variableForPrimaryKey += 1
                    let data = dataItem(id: item["id"] ?? "N/A", date: item["date"] ?? "N/A", data: item["data"] ?? "No data present.", type: item["type"] ?? "N/A", myId: "\(variableForPrimaryKey)")
                    self.dataListArray.append(data)
                        try! self.realm.write {  // saving data to Realm
                            self.realm.add(data)
                    }
                    let saveData = self.realm.object(ofType: dataItem.self, forPrimaryKey: data.myId)
                    print("Databse data: ",saveData?.data as Any)
                }
                self.sortArrayAndReloadCollection()
                break
            case .failure(_):
                print("Error")
                break
                
            }
        }
        
    }
}

//MARK: - Extension

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentCellData = dataListArray[indexPath.row]
        
        let imageLinkContains = loadImageView.urlFromString(text: currentCellData.data)
        if imageLinkContains != ""{
            return CGSize(width: view.frame.width, height: 200)
        }
        
        // Calculate estimate size of cell for display full text
        let widthOfDataLabel = view.frame.width - 28
        let totalSize = CGSize(width: widthOfDataLabel, height: 1000)
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let actualString = currentCellData.data.replacingOccurrences(of: "\n", with: "")
        let estimatedSize = NSString(string: actualString).boundingRect(with: totalSize, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        
        return CGSize(width: view.frame.width, height: estimatedSize.height + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
