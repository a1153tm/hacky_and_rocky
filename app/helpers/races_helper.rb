module RacesHelper
  def rowText(text)
    result = ''
    textArr = text.split(//)
    textArr.each do |char|
      result += char+'<br />'
    end
    return result
  end
end
