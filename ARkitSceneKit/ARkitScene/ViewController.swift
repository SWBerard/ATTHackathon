//
//  ViewController.swift
//  ARkitScene
//
//  Created by Joshua Homann on 6/24/17.
//  Copyright © 2017 josh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var textViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var textView: UITextView!
    var userAnchorIds: Set<UUID> = []
    var supermanNodes: Set<SCNNode> = []
    var batmanNodes: Set<SCNNode> = []
    var wonderWomanNodes: Set<SCNNode> = []
    var aquamanNodes: Set<SCNNode> = []
    var supermanVideoNode: SCNNode!
    var batmanVideoNode: SCNNode!
    var wonderWomanVideoNode: SCNNode!
    var auqamanVideoNode: SCNNode!
    var dcLogoNode: SCNNode!
    static let modelScale: Float = 0.1
    lazy var superman: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/ss.dae")!.rootNode
        let node = SCNNode()
        let wrapper = SCNNode()
        wrapper.transform = SCNMatrix4MakeScale(1/212.0*modelScale*1, 1/212.0*modelScale*1,1/212.0*modelScale*1)
        scene.childNodes.forEach {
            wrapper.addChildNode($0)
        }
        self.supermanNodes = wrapper.descendents
        node.addChildNode(wrapper)
        return node
    }()
    lazy var batman: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/batmanidle.dae")!.rootNode
        let node = SCNNode()
        let wrapper = SCNNode()

        scene.childNodes.forEach {
            wrapper.addChildNode($0)
        }
        self.batmanNodes = wrapper.descendents
        wrapper.transform = SCNMatrix4MakeScale(1/wrapper.boundingSphere.radius*modelScale*0.6, 1/wrapper.boundingSphere.radius*modelScale*0.6, 1/wrapper.boundingSphere.radius*modelScale*0.6)
        node.addChildNode(wrapper)
        return node
    }()
    lazy var wonderWoman: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/ww2.dae")!.rootNode
        let node = SCNNode()
        let wrapper = SCNNode()
        wrapper.transform = SCNMatrix4MakeScale(1/212*modelScale, 1/212*modelScale,1/212*modelScale)
        scene.childNodes.forEach {
            wrapper.addChildNode($0)
        }
        self.wonderWomanNodes = wrapper.descendents
        node.addChildNode(wrapper)
        return node
    }()
    lazy var aquaman: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/aman.dae")!.rootNode
        let node = SCNNode()
        let wrapper = SCNNode()
        wrapper.transform = SCNMatrix4MakeScale(1/220*modelScale, 1/220*modelScale,1/220*modelScale)
        scene.childNodes.forEach {
            wrapper.addChildNode($0)
        }
        self.aquamanNodes = wrapper.descendents
        node.addChildNode(wrapper)
        return node
    }()

    lazy var heroNode: SCNNode = {
        let node = SCNNode()
        for (index, model) in [self.superman, self.batman, self.aquaman, self.wonderWoman].enumerated() {
            let wrapper = SCNNode()
            wrapper.transform = SCNMatrix4MakeTranslation((1 - 0.5 * Float(index) - 0.25) * 0.25, 0, 0)
            wrapper.addChildNode(model)
            node.addChildNode(wrapper)
        }


        let scene = SCNScene(named: "art.scnassets/dc.dae")!.rootNode
        let dc = SCNNode()
        let wrapper = SCNNode()
        scene.childNodes.forEach {
            wrapper.addChildNode($0)
        }
        self.dcLogoNode = wrapper.childNodes.first
        wrapper.transform = SCNMatrix4Translate(SCNMatrix4MakeScale(1/wrapper.boundingSphere.radius*modelScale*0.25, 1/wrapper.boundingSphere.radius*modelScale*0.25, 1/wrapper.boundingSphere.radius*modelScale*0.25), -1/wrapper.boundingSphere.radius*modelScale*0.25*0.25, 0, 0) 
        node.addChildNode(wrapper)

        let hieght: CGFloat = 9.0/16.0
        self.supermanVideoNode = self.createVideoNode(width: 0.3, height:hieght * 0.3)
        self.supermanVideoNode.transform = SCNMatrix4MakeTranslation(0, 0.15, -0.1)
        node.addChildNode(self.supermanVideoNode)
        let url = Bundle.main.url(forResource: "dcLegendsTrailer", withExtension: "mp4")!
        self.assignVideoTexture(url: url)
        return node
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.session.delegate = self
        // Set the scene to the view
        sceneView.scene = SCNScene()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        sceneView.addGestureRecognizer(recognizer)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        sceneView.addGestureRecognizer(pinch)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        sceneView.addGestureRecognizer(pan)
        //textViewWidthConstraint.constant = .ulpOfOne
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        // Run the view's session
        sceneView.session = ARSession()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.showsStatistics = true
        sceneView.scene.rootNode.addChildNode(batman)
        log(text: "start logging")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }

    @objc func tap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        let geometeryHits = sceneView.hitTest(location, options: nil)
        if let node = geometeryHits.first?.node {
            if node === supermanVideoNode {

            } else if node === dcLogoNode {
                let url = Bundle.main.url(forResource: "dcLegendsTrailer", withExtension: "mp4")!
                assignVideoTexture(url: url)
            } else if supermanNodes.contains(node) {
                let url = Bundle.main.url(forResource: "supermanMovie", withExtension: "mp4")!
                assignVideoTexture(url: url)
            } else if wonderWomanNodes.contains(node) {
                let url = Bundle.main.url(forResource: "wonderWomanMovie", withExtension: "mp4")!
                assignVideoTexture(url: url)
            } else if aquamanNodes.contains(node){
                let url = Bundle.main.url(forResource: "aquamanMovie", withExtension: "mp4")!
                assignVideoTexture(url: url)
            } else if batmanNodes.contains(batman) {
                let url = Bundle.main.url(forResource: "batmanMovie", withExtension: "mp4")!
                assignVideoTexture(url: url)
            }
            return
        }

        let normalizedPoint = CGPoint(x: location.x / view.bounds.size.width, y: location.y / view.bounds.size.height)
        let results = sceneView.session.currentFrame?.hitTest(normalizedPoint, types: [.estimatedHorizontalPlane, .existingPlane])
        guard let closest = results?.first else {
            return
        }
        let hitAnchor = ARAnchor(transform: closest.worldTransform)
        userAnchorIds.insert(hitAnchor.identifier)
        sceneView.session.add(anchor: hitAnchor)
    }

    @objc func pinch(recognizer: UIPinchGestureRecognizer) {
        print(superman.scale.x)
        let scale = 0.9*recognizer.scale + 0.1*recognizer.scale * CGFloat(heroNode.presentation.scale.x)
        heroNode.scale = .init(scale, scale, scale)
    }

    @objc func pan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            heroNode.removeAllAnimations()
        case .changed:
            let delta = recognizer.translation(in: sceneView)
            let rotationY = delta.x / UIScreen.main.bounds.size.width * CGFloat.pi * 2
            heroNode.eulerAngles = SCNVector3(0, rotationY, 0)
        case .cancelled, .ended, .failed:
            break
        default:
            break
        }
    }

    var isDebugViewVisible = false

    func toggleDebugView() {
        if isDebugViewVisible {
            isDebugViewVisible = false
            textViewWidthConstraint.constant = .ulpOfOne
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            isDebugViewVisible = true
            textViewWidthConstraint.constant = 200
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

    func createVideoNode(width: CGFloat, height: CGFloat) -> SCNNode {
        let videoNode = SCNNode()
        videoNode.geometry = SCNPlane(width: width, height: height)
       return videoNode

    }

    func assignVideoTexture(url: URL) {
        let spriteKitScene = SKScene(size: CGSize(width: 1276.0 / 2.0, height: 712.0 / 2.0))
        let videoSpriteKitNode = SKVideoNode(url: url)
        spriteKitScene.scaleMode = .aspectFill
        videoSpriteKitNode.position = CGPoint(x: spriteKitScene.size.width / 2.0, y: spriteKitScene.size.height / 2.0)
        videoSpriteKitNode.size = spriteKitScene.size
        videoSpriteKitNode.yScale = -1
        spriteKitScene.addChild(videoSpriteKitNode)
        supermanVideoNode.geometry?.firstMaterial?.diffuse.contents = spriteKitScene
        supermanVideoNode.geometry?.firstMaterial?.isDoubleSided = true
        videoSpriteKitNode.play()
    }

    func log(text: CustomStringConvertible) {
        textView.text.append(text.description)
    }
}

extension ViewController: ARSessionDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard userAnchorIds.contains(anchor.identifier) else {
            return nil
        }
        return heroNode
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print(type(of: anchor))

        if let anchor = anchor as? ARPlaneAnchor {
            self.log(text: "Adding plane anchor: \(anchor)")
            let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
            let planeNode = SCNNode(geometry: plane)
            planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
            node.addChildNode(planeNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print(anchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        print(anchor)
    }
    func session(_ session: ARSession, didUpdate frame: ARFrame) {

    }

//    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//        let a = anchors.filter ({$0 is ARPlaneAnchor})
//        if a.count > 0 {
//            log(text: a)
//        }
//
//    }

    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            self.log(text:"Tracking normal")
        case .notAvailable:
            self.log(text: "Not Available")
        case .limited(let reason):
            self.log(text: "Limited Tracking: \(reason)")
        }
    }
}

extension SCNNode {
    var descendents: Set<SCNNode> {
        var nodes: Set<SCNNode> = []
        var queue: [SCNNode] = []
        queue.append(self)
        while !queue.isEmpty {
            let current = queue.first!
            queue.removeFirst()
            current.childNodes.forEach {
                nodes.insert($0)
                queue.append($0)
            }
        }
        return nodes
    }
}
