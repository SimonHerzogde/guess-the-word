//
//  ViewController.swift
//  Aufgabe_03
//
//  Created by Simon Herzog on 24.03.21.
//

import Cocoa

class ViewController: NSViewController {
    //Outlets für das Fragewort, die Versuchsanzahl und für den Pop-Up-Button
    @IBOutlet weak var labelQuestionWord: NSTextField!
    @IBOutlet weak var labelAttempts: NSTextField!
    @IBOutlet weak var listOfCharacters: NSPopUpButton!
    
    //Array für die Fragewörter und für die Buchstaben bzw. das Alphabet, beide vom Typ String
    let questionWords = ["AUTO", "HUMMEL", "ALPENVORLAND", "GLASMANUFAKTUR", "SAUERSTOFFFLASCHE", "BENZINFEUERZEUG", "MONITOR", "EINKAUFSZENTRUM", "SPIELPLATZ", "HUNDEHUETTE"]
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    //leeres Array für das Fragewort, welches die einzelnen Buchstaben des Wortes speichert
    var wordInChars = [Character]()
    //leeres Array für die dargestellten Sterne, das "versteckte" Fragewort
    var displayedStars = [Character]()
    //Zählervariable für die Versuche
    var attempts = 10
    
    //Action für den Pop-Up-Button die ausgelöst wird, wenn Buchstabe ausgewählt wird
    @IBAction func clickedPopUp(_ sender: Any) {
        //Aktuell Ausgewählten Character holen
        //String wird in Char gecastet und Konstaten zugewiesen
        let selectedChar = Character(listOfCharacters.titleOfSelectedItem!)
        
        //Wenn der Buchstabe schon aufgedeckt wurde, soll kein Versuch abgezogen werden und es wird return ausgeführt und somit action beendet
        if displayedStars.contains(selectedChar) == true {
            return
        }
        
        //Prüfe allgemein ob ausgewählter Buchstabe im Fragewort vorhanden ist, wenn true gehts in die for-Schleife, wenn false dann wird ein Punkt abgezogen
        if wordInChars.contains(selectedChar) == true {
            //Schleife geht alle Buchstaben im Ratewort durch
            for char in wordInChars{
                //wenn der ausgewählte Buchstabe dem Buchstaben im Ratewort entspricht
                if selectedChar == char{
                    //wird Index besorgt und einer Konstanten zugewiesen, ist hier nich notwendig aber der Übersicht halber habe ich das so gelöst. Könnte index auch mit displayedStars[wordInChars.firstIndex(of: char) abrufen
                    let indexOfChar = wordInChars.firstIndex(of: char)
                    //da Indexbereich der Arrays vom Ratewort und der Sterne gleich ist, wird an dem Index, wo sich der Buchstabe im Ratewort befindet, der Stern mit dem Buchstaben ausgetauscht
                    displayedStars[indexOfChar!] = char
                    //Aktualisierung der Fragewort-Anzeige
                    labelQuestionWord.stringValue = String(displayedStars)
                    
                    
                    //da ich die Länge des Wortes im Array nicht ändern will (mit remove o.ä.), damit der Index der Sterne und des Ratewortes gleich bleibt, ändere ich im Wort-Array den gefunden Buchstaben in ein Stern um. Würde ich das nicht machen. würde die Methode .firstIndex(of:) immer wieder den Index des ersten gefundenen Buchstaben zuweisen
                    wordInChars[indexOfChar!] = "*"
                    //Überprüfung, ob im Array der Sterne noch ein Stern vorhanden ist. Wenn nicht, ist das Spiel gewonnen, es wird eine Nachricht ausgegeben und das Spiel beendet.
                    if displayedStars.contains("*") == false {
                        creatMessage(title: "Herzlichen Glückwunsch", text: "Du hast das Spiel gewonnen")
                        NSApplication.shared.terminate(self)
                    }
                }
            }
        }
        
        else{
            //1 Versuch abziehen wenn Buchstabe nicht vor kommt
            attempts -= 1
            //Aktualisierung der Anzeige
            labelAttempts.stringValue = String(attempts)
            //Wenn kein Versuch mehr übrig ist wird Meldung aufgerufen und die App beendet
            if attempts == 0 {
                creatMessage(title: "Oh nein", text: "Du hast leider verloren")
                NSApplication.shared.terminate(self)
            }
            }
    }
    
    //Methode zur Initialisierung des Spiels
    func initGame(){
        //Löschen der Items im Pop-Up-Button
        listOfCharacters.removeAllItems()
        //Alphabet dem Pop-Up-Button zuweisen
        listOfCharacters.addItems(withTitles: alphabet)
        //Wort aus Wortliste zufällig auswählen
        //Einzelne Zeichen des Wortes als Char-Array in Konstante speichern
        wordInChars = Array(questionWords[Int.random(in: 0...(questionWords.count - 1))])
        //Sterne in Anzahl der Buchstaben des Wortes generieren und dem Array zuweisen
        displayedStars = Array(repeating: "*", count: wordInChars.count)
        //Sterne im Label anzeigen
        labelQuestionWord.stringValue = String(displayedStars)
        
    }
    //Methode zur Generierung von Nachrichten
    func creatMessage(title: String, text: String) {
        let newMessage = NSAlert()
        newMessage.messageText = title
        newMessage.informativeText = text
        newMessage.addButton(withTitle: "Spiel beenden")
        newMessage.runModal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGame()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            
        }
    }


}

