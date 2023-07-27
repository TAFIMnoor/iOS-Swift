//
//  ViewController.swift
//  MetalIntroduction
//
//  Created by mohammad noor uddin on 26/7/23.
//

import UIKit
import MetalKit
import Metal

class ViewController: UIViewController {
    
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var metalLayer: CAMetalLayer!
    var vertexBuffer: MTLBuffer!
    var pipelineState: MTLRenderPipelineState!
    
    //
    var timer: CADisplayLink!


    
    let vertexData: [Float] = [
       0.0,  1.0, 0.0,
      -1.0, -1.0, 0.0,
       1.0, -1.0, 0.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        device = MTLCreateSystemDefaultDevice()

        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        
        //
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: [])
        
        //
        let defaultLibrary = device.makeDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
            
        //
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            
        //
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        
        //
        commandQueue = device.makeCommandQueue()
        
        /*
         Now, it’s time to move on to the code that executes each frame — to render the triangle!
         This is done in five steps:
         Create a Display Link
         Create a Render Pass Descriptor
         Create a Command Buffer
         Create a Render Command Encoder
         Commit your Command Buffer
        */
        
        timer = CADisplayLink(target: self, selector: #selector(gameloop))
        timer.add(to: RunLoop.main, forMode: .default)

    }
    
    func render() {
        
        //Creating a Render Pass Descriptor
        
        guard let drawable = metalLayer?.nextDrawable() else { return }
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(
          red: 0.0,
          green: 104.0/255.0,
          blue: 55.0/255.0,
          alpha: 1.0)
        
        //Creating a Command Buffer
        
        let commandBuffer = commandQueue.makeCommandBuffer()!
        
        //Creating a Render Command Encoder
        
        let renderEncoder = commandBuffer
          .makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder
          .drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()
        
        // Committing Your Command Buffer
        commandBuffer.present(drawable)
        commandBuffer.commit()

    }

    @objc func gameloop() {
      autoreleasepool {
        self.render()
      }
    }



}
