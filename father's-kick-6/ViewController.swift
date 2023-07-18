import UIKit

class ViewController: UIViewController {
    lazy private var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
    lazy private var animatingView: UIView = {
        let view = UIView(frame: .init(x: view.frame.midX - 75 / 2,
                                       y: view.frame.midY - 75 / 2 ,
                                       width: 75, height: 75))
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    var animator: UIDynamicAnimator?
    var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupGesture()
        setupAnimatingView()
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    private func setupGesture() {
        view.addGestureRecognizer(tapGesture)
     
    }
    
    private func setupAnimatingView() {

        view.addSubview(animatingView)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: view)
        if (snap != nil) {
            animator?.removeBehavior(snap!)
        }
        
        snap = UISnapBehavior(item: animatingView, snapTo: tapPoint)
        animator?.addBehavior(snap!)
    }
}
