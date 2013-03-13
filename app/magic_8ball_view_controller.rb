class Magic8ballViewController < UIViewController

  def loadView
    self.view = UIImageView.alloc.init
  end

  def viewDidLoad
    @label = makeLabel

    view.image = UIImage.imageNamed('background.png')

    view.addSubview @label

    view.userInteractionEnabled = true

    recognizer = UITapGestureRecognizer.alloc.initWithTarget self,
                                                             action:'showAnswer'
    view.addGestureRecognizer recognizer

    @magicBall = Magic8BallModel.new

  end

  def showAnswer
    UIView.animateWithDuration  1.0,
                                animations:showAnswerAnimateIn[:animations],
                                completion:showAnswerAnimateIn[:completion]
  end

  def showAnswerAnimateIn
    options = {}

    options[:animations] =  lambda {
                              @label.alpha      = 0
                              @label.transform  = CGAffineTransformMakeScale 0.1, 0.1
                            }

    options[:completion] =  lambda { |finished|
                              @label.text = @magicBall.randomAnswer
                              UIView.animateWithDuration  1.0,
                                                          animations:showAnswerAnimateOut[:animations]
                            }
    options
  end

  def showAnswerAnimateOut
    options = {}

    options[:animations] =  lambda {
                              @label.alpha = 1
                              @label.transform = CGAffineTransformIdentity
                            }
    options
  end

  def makeLabel
    label = UILabel.alloc.initWithFrame [ [10,60], [300, 80] ]

    label.textColor        = UIColor.whiteColor
    label.backgroundColor  = UIColor.lightGrayColor
    label.text             = "Click me!"
    label.font             = UIFont.boldSystemFontOfSize 34
    label.textAlignment    = UITextAlignmentCenter

    label
  end
end
