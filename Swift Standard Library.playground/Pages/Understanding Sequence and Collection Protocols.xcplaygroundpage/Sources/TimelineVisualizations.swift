import UIKit

private final class TimelineCollectionCell: UICollectionViewCell {
    let photoView = UIImageView()
    let dateLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        photoView.contentMode = .ScaleAspectFit
        photoView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(photoView)
        
        dateLabel.font = UIFont.systemFontOfSize(12)
        dateLabel.textAlignment = .Right
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dateLabel)
        
        let hPhotoConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[photoView]|",
            options: [],
            metrics: nil,
            views: ["photoView": photoView])
        let hDateConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[dateLabel]|",
            options: [],
            metrics: nil,
            views: ["dateLabel": dateLabel])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[dateLabel(<=14)]-3-[photoView(134)]|",
            options: [],
            metrics: nil,
            views: ["photoView": photoView, "dateLabel": dateLabel])
        self.contentView.addConstraints(hPhotoConstraints + hDateConstraints + vConstraints)
    }
}

private final class TimelineCollectionController: UICollectionViewController {
    let timelineCellIdentifier = "TimelineCellIdentifier"
    
    var elements = [(date: String, image: UIImage?)]()
    
    override func viewDidLoad() {
        self.collectionView!.backgroundColor = .whiteColor()
        collectionView!.registerClass(TimelineCollectionCell.self, forCellWithReuseIdentifier: timelineCellIdentifier)
        self.view.frame.size = CGSize(width: 1180, height: 160)
        collectionView!.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(timelineCellIdentifier, forIndexPath: indexPath) as! TimelineCollectionCell
        
        let (date, image) = elements[indexPath.row]
        cell.photoView.image = image ?? UIImage(named: "NoImage.jpg")
        cell.dateLabel.text = date
        
        return cell
    } 
}

// UICollectionViewControllers are deallocated before their collection view is rendered unless you store them somewhere.
private var timelines = [TimelineCollectionController]()

private final class BorderView: UIView {
    private override func drawRect(rect: CGRect) {
        UIColor(white: 0.75, alpha: 1.0).set()
        UIRectFill(rect)
    }
}

private func showTimelineCollection(elements: [(date: String, image: UIImage?)]) -> UIView {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .Horizontal
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 7
    layout.itemSize = CGSize(width: 134, height: 150)
    let timeline = TimelineCollectionController(collectionViewLayout: layout)
    timeline.elements = elements
    timelines.append(timeline)

    let topBorder = BorderView(frame: CGRect(x: 0, y: 0, width: 1180, height: 1))
    let bottomBorder = BorderView(frame: CGRect(x: 0, y: 161, width: 1180, height: 1))
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 1180, height: 162))
    view.addSubview(topBorder)
    timeline.view.frame.origin.y = 1
    view.addSubview(timeline.view)
    view.addSubview(bottomBorder)
    
    return view
}
public let mayFirst = NSDate(timeIntervalSince1970: 1.4305*pow(10, 9))
public let maySeventh = NSDate(timeIntervalSince1970: 1.431*pow(10, 9))

public func visualize<T: CollectionType where T.Index: CustomDebugStringConvertible, T.Generator.Element == UIImage?>(collection: T) -> UIView {
    let elements = zip(collection.indices, collection).map { date, image in
        return (date: date.debugDescription, image: image)
    }
    
    return showTimelineCollection(elements)
}
