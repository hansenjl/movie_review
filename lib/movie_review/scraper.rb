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

    movie.audience_score = review_page.css("div.meter-value span.superPageFontColor").text
    revs = review_page.css("div#reviews div.top_critic")
    revs.each do |review|
      r = MovieReview::Review.new
      r.quote = review.css("div.media div.media-body p").text.strip
      r.author =  review.css("div.review_source div.media-body a.articleLink")[0].text
      r.movie = movie
      r.press = review.css("div.review_source div.media-body a.subtle").text
      movie.reviews << r
    end
  end
end