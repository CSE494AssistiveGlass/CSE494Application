//
//  ViewController.swift
//  VoiceRecognition
//
//  Created by Alex Panza on 3/15/18.
//  Copyright © 2018 Alex Panza. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBAction func buttonPushed(_ sender: UIButton) {
        
        self.recordAndRecognizeSpeech()
    }
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var alex: String?
    
    @IBOutlet var label1: UILabel!

    @IBOutlet var Button: UIButton!
    
    @IBOutlet var labelOut: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    
    func recordAndRecognizeSpeech()
    {
        guard let node = audioEngine.inputNode else {return}
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){buffer, _ in self.request.append(buffer) }
        
        audioEngine.prepare()
        do{
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        
        if !myRecognizer.isAvailable{
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {result, error in
            if let result = result {
                 self.alex = result.bestTranscription.formattedString
                self.labelOut.text = self.alex
            }
            else if let error = error {
                print(error)
            }
            
        })
        
       
        
    }
    
    

}

