class MovieReview::Movie
  attr_accessor :title, :rating, :critic, :url, :directed_by



  @@all = []

  def initialize(att_hash)
   # @title = att_hash[:title]
    #@rating = att_hash[:rating]

    att_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.save
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end



end