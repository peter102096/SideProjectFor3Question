import UIKit

class BikeTableViewCell: UITableViewCell {
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    private(set) var model: YouBike2_0Model? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(model: YouBike2_0Model) {
        self.model = model
        countyLabel.text = "台北市"
        areaLabel.text = model.sarea
        stationNameLabel.text = model.sna
    }
}
