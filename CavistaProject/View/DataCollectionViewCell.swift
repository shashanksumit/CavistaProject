import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Overriden Methods
    
    // Called when a cell is dequeue
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        setCellsView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup Cell label and imageview in a cell
    func setCellsView(){
        idLabelSetting() // Adding IdLabel in cell
        dateLabelSetting() // Adding Date label in cell
        textLabelSetting() // Adding Data Label in cell
        imageViewSetting() // Adding image view
        createLabelForCellSeperator() // creating a seperator line between cells
    }
    
   /*ID label cration  and setting constarints for cell*/
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Add label to cell and give constraints
    func idLabelSetting(){
        // Add a label to cell as subview
        addSubview(idLabel)
        // set constarints to Label
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        idLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 150).isActive = true
    }
    /*Finish ID label cration  and setting constarints for cell*/
    
    /*Date label cration  and setting constarints for cell*/
    let dateLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func dateLabelSetting(){
        addSubview(dateLabel)
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: idLabel.widthAnchor,  constant: 8).isActive = true
    }
    /*Finish Date label cration  and setting constarints for cell*/
    
    /*Text view  cration  and setting constarints for cell*/
    let textLabel:UITextView = {
        let label = UITextView()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Add label to cell and give constraints
    func textLabelSetting(){
        // Add a label to cell as subview
        addSubview(textLabel)
        // set constarints to Label
        textLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 0).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
    /*Finish Text view  cration  and setting constarints for cell*/
    
    
    /*Image view  cration  and setting constarints for cell*/
    let imageView:UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Add label to cell and give constraints
    func imageViewSetting(){
        // Add a label to cell as subview
        addSubview(imageView)
        // set constarints to Label
        imageView.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    /*Finish image view  cration  and setting constarints for cell*/
    
    /*Seperator line cration  and setting constarints for cell*/
    let seperatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func createLabelForCellSeperator(){
        addSubview(seperatorLabel)
        
        // setting appropriate constarint for seperator cell
        seperatorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true  // left to 0
        seperatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true //bottom 0
        seperatorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true // right 0
        seperatorLabel.heightAnchor.constraint(equalToConstant: 2).isActive = true  // height of seperator label
    }
    /*Finish Seperator line cration  and setting constarints for cell*/
}
