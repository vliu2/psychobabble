import UIKit

private let reuseIdentifier = "Cell"
let kRoomCellScaling: CGFloat = 0.6

class RoomsViewController: UICollectionViewController {

override func viewDidLoad() {
    super.viewDidLoad()

    // This method sets up the collection view
    let layout = UPCarouselFlowLayout()
    layout.itemSize = CGSizeMake(250, 250)
    layout.scrollDirection = .Horizontal

    layout.sideItemAlpha = 1
    layout.sideItemScale = 0.8
    layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60)

    collectionView?.setCollectionViewLayout(layout, animated: false)

}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}



// MARK: UICollectionViewDataSource

override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}


override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return 3
}

override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)



    // Configure the cell
    switch indexPath.row%3 {

    case 0:
        cell.backgroundColor = UIColor.redColor()
    case 1:
        cell.backgroundColor = UIColor.blackColor()
    case 2:
        cell.backgroundColor = UIColor.blueColor()

    default:
        break

    }

    return cell
}


}
