//
//  ViewController.swift
//  SentimentAnalysisByApple
//
//  Created by Juliano Vaz on 31/08/20.
//  Copyright © 2020 Juliano Vaz. All rights reserved.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {

    @IBOutlet weak var sentimentLabelByModel: UILabel!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var mesageTextView: UITextView!
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let message = self.mesageTextView?.text else {
                  return
        }
        
        detectSentimentWithModel(message: message)
        detectSentiment(message: message)
         
    }
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        // Do any additional setup after loading the view.
    //    }
        


    private func detectSentimentWithModel(message: String) {
        do {
            let sentimentDetector = try NLModel(mlModel: AnRandomSentimentClassifier().model)
            guard let prediction = sentimentDetector.predictedLabel(for: message) else {
                print("Failed to predict result")
                return
            }
            
            sentimentLabelByModel?.text = "Our status: \(prediction)"
        } catch {
            fatalError("Failed to load Natural Language Model: \(error)")
        }
    }


   // range -1.0 (negative) to 1.0 (positive)
    private func detectSentiment(message: String) {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = message
        
        let (sentiment, _) = tagger.tag(at: message.startIndex, unit: .paragraph, scheme: .sentimentScore)
        
        // it supports 7 languages: English, French, Italian, German, Spanish, Portuguese, and simplified Chinese.
        guard let sentimentScore = sentiment?.rawValue else {
            return
        }
        
        sentimentLabel?.text = "sentiment score: \(sentimentScore)"
    }
}

    


