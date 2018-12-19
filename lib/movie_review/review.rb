class MovieReview::Review
  attr_accessor :author, :quote, :press, :movie
  @@all = []
  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end