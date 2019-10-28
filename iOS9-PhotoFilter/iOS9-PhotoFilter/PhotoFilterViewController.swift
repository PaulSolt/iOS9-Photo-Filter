import UIKit
import CoreImage
import Photos

class PhotoFilterViewController: UIViewController {

	// Instance variables
	private let context = CIContext(options: nil)
	private let filter = CIFilter(name: "CIColorControls")!
	
	var originalImage: UIImage?
	
	// Outlets
	@IBOutlet var brightnessSlider: UISlider!
	@IBOutlet var contrastSlider: UISlider!
	@IBOutlet var saturationSlider: UISlider!
	@IBOutlet var imageView: UIImageView!
	
	// Init / ViewDidLoad / Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// TEST: Use the storyboard image to start (Fake it till we make it)
		originalImage = imageView.image
	}
	
	// MARK: Actions
	
	@IBAction func choosePhotoButtonPressed(_ sender: Any) {
		// TODO: show the photo picker so we can choose on-device photos
		// UIImagePickerController + Delegate
	}
	
	@IBAction func savePhotoButtonPressed(_ sender: UIButton) {


	}
	
	// MARK: Slider events
	
	@IBAction func brightnessChanged(_ sender: UISlider) {
		updateImage()
	}
	
	@IBAction func contrastChanged(_ sender: Any) {
		updateImage()
	}
	
	@IBAction func saturationChanged(_ sender: Any) {
		updateImage()
	}
	
	// Instance methods
	
	// public
	// private (internal use only)
	
	
	// Clean Code + Clean Coder
	
	private func filterImage(_ image: UIImage) -> UIImage? {
		let ciImage = originalImage?.ciImage
		
		// set the filter
		
		
		// render the image
		
		return nil
	}
	
	private func updateImage() {
		if let image = originalImage {
			imageView.image = filterImage(image)
		}
	}
	
	
}

