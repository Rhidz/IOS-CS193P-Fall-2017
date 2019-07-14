import UIKit

@IBDesignable
class GridView: UIView {
   
   private(set) lazy var deckOfCards = createDeck()
    
   lazy var grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 128.0, height: 110.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))
   
    lazy var listOfSetCard = createSetCards()
    
    private func createDeck() -> [SetCard] {
        var deck = [SetCard]()
        for shape in SetCard.Shape.allShape {
            for color in SetCard.Color.allColor {
                for content in SetCard.Content.allContent {
                    for number in SetCard.Number.allNumbers {
                        deck.append(SetCard(shape: shape, color: color, content: content, rank: number))
                    }
                }
            }
        }
        deck.shuffle()
        return deck
    }
    @IBInspectable
    var cardsOnScreen:Int = 12 { didSet { setNeedsLayout() } }
    
    var trackOfCards: Int {
        get {
            return cardsOnScreen
        }
        set(newValue) {
            self.trackOfCards = newValue
        }
    }
    
    private func createSetCards() -> [SetView] {
        var cards = [SetView]()
        for _ in 0..<cardsOnScreen {
            let card = SetView()
            let contentsToBeDrawn = deckOfCards.removeFirst()
            card.combinationOnCard.shape = contentsToBeDrawn.shape
            card.combinationOnCard.color = contentsToBeDrawn.color
            card.combinationOnCard.content = contentsToBeDrawn.content
            card.combinationOnCard.rank = contentsToBeDrawn.rank
            /* print(contentsToBeDrawn.color) */
            addSubview(card)
            cards.append(card)
        }
        return cards
    }
  override func layoutSubviews() {
        super.layoutSubviews()
        for index in listOfSetCard.indices {
            let card = listOfSetCard[index]
            if let rect = grid[index] {
                card.frame = rect.insetBy(dx: 2.5, dy: 2.5)
                card.frame.origin = rect.origin
                print(card.frame.origin)
            }
        }
    }
    override func draw(_ rect: CGRect) {
         let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 15.0)
         let color = #colorLiteral(red: 0.8445288539, green: 0.1451442242, blue: 0.3822338581, alpha: 0.9444295805)
         color.setFill()
         roundedRect.fill()
    }
}