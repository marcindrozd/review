require 'digest/sha1'

class StringColorizer

  def initialize(string)
    @string = string
  end

  def hexcolor
    "##{Digest::SHA1.hexdigest(@string)[0...6]}"
  end
end
