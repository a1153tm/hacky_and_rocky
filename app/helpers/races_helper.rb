module RacesHelper

  #出走の色付け -> show
  def horse_number_colors(number)
    horseNumberColors = ['white','black','red','blue','yellow','green','orange','pink','skyblue','limegreen']
    currentColor = nil
    if horseNumberColors.size - 1 >= number
      currentColor = horseNumberColors[number]
    end
    return currentColor
  end
  
  #出走馬の色付け
  def search_expectation( number )
    return VoteItem::EXPECTATION[number]
  end
  
  #縦書き表示 -> show
  def row_text(text)
    result = ''
    textArr = text.split(//)
    textArr.each do |s|
      s = s === "ー" ? "｜" : s ;
      result += s + '<br />'
    end
    return result
  end
  
end
