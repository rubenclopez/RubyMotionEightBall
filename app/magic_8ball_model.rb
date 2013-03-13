class Magic8BallModel

  def initialize
    @answer = loadAnswers
  end

  def loadAnswers
    answerFile = NSBundle.mainBundle.pathForResource 'answers', ofType:'json'

    errorPointer = Pointer.new(:object)

    data = NSData.alloc.initWithContentsOfFile answerFile,
                                              options:NSDataReadingUncached,
                                              error:errorPointer

    unless data
      printError errorPointer[0]
      defaultAnswers
    end

    json = NSJSONSerialization.JSONObjectWithData data,
                                                  options:NSDataReadingUncached,
                                                  error:errorPointer
    unless json
      printError errorPointer[0]
      defaultAnswers
    end

    json['answers']
  end

  def printError(error)
    $stderr.puts "!!!!!!!!!!!!!!!!! [Error]: #{error.description}"
  end

  def randomAnswer
    @answer.sample
  end

  def defaultAnswers
    %w|yes no maybe perhaps|
  end
end
