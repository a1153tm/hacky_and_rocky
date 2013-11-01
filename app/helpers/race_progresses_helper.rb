module RaceProgressesHelper
  
  #出走の色付け -> show
  def horse_number_color(number)
    horseNumberColors = ['white','black','red','blue','orange','green','pink','skyblue','yellow','limegreen']
    currentColor = nil
    if horseNumberColors.size - 1 >= number
      currentColor = horseNumberColors[number]
    end
    return currentColor
  end
  
end
