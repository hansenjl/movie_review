class MovieReview::Scraper

  def self.scrape_movies
      index_page = Nokogiri::HTML(open("https://editorial.rottentomatoes.com/guide/best-movies-of-2018/"))

      array_of_movies = index_page.css("div.countdown-item")

      array_of_movies[0...100].each do |movie_card|
        attributes = {
          title: movie_card.css("div.article_movie_title a")[0].children.text ,
          url: movie_card.css("div.article_movie_title a")[0].attributes['href'].value,
          rating: movie_card.css('span.tMeterScore').text,
          critic: movie_card.css("div.critics-consensus").text
          # synopsis: ,
          # starring: ,
          # directed_by: ,
        }
        movie = MovieReview::Movie.new(attributes)
      end


  end

  def self.scrape_reviews(movie)
    review_page = Nokogiri::HTML(open(movie.url))


  end
end