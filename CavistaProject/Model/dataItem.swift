import Foundation
import UIKit
import Realm
import Unrealm

struct dataItem: Realmable{
    var id:String = ""
    var date:String = ""
    var data:String = ""
    var type:String = ""
    var myId:String = ""
    
    static func primaryKey() -> String? {
        return "myId"
    }
}

class loadImageView{
    static var imageCache = NSMutableDictionary()
    static func loadImage(_ urlString: String, handler:@escaping (_ image:UIImage?)-> Void)
    {
        if let img = imageCache.value(forKey: urlString) as? UIImage{
            handler(img)
        }
        
        let imageURL: URL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
            if let data = data{
                let img = UIImage(data: data)
                self.imageCache.setValue(img, forKey: urlString)
                handler(img)
            }else{
                let img = UIImage(named: "no-image-available")
                self.imageCache.setValue(img, forKey: urlString)
                handler(img)
            }
        }.resume()
    }
    
    // Checking String contains Link and return
    static func urlFromString(text:String) -> String{
        var linkMatch = ""
       let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)


        let matches = detector.matches(in: text, options: [], range: NSMakeRange(0, (text as NSString).length))

       for match in matches {
        linkMatch = "\((text as NSString).substring(with: match.range))"
       }
        return linkMatch
    }
}
