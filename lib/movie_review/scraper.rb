class MovieReview::Scraper

  def self.scrape_movies
      index_page = Nokogiri::HTML(open("https://editorial.rottentomatoes.com/guide/best-movies-of-2018/"))

      array_of_movies = index_page.css("div.countdown-item")

      array_of_movies[0...100].each_with_index do |movie_card, index|
        attributes = {
          title: movie_card.css("div.article_movie_title a")[0].children.text ,
          url: movie_card.css("div.article_movie_title a")[0].attributes['href'].value,
          rating: movie_card.css('span.tMeterScore').text,
          critic: movie_card.css("div.critics-consensus").text,
          id: index + 1
          # synopsis: ,
          # starring: ,
          # directed_by: ,
        }
        movie = MovieReview::Movie.new(attributes)
      end
  end

  def self.scrape_reviews(movie_object)
    review_page = Nokogiri::HTML(open(movie_object.url))
    reviews = review_page.css("div.top_critic") #array of reviews

    reviews.each do |review_html|
       #instantiate a new review
       ro = MovieReview::Review.new
      # ro stands for review object
      # associate that review with this movie
      #ro.movie = movie_object
      # set any review attributes

      ro.quote = review_html.css("div.media div.media-body p").text.strip

      ro.author = review_html.css("div.review_source div.media-body a.unstyled").text

      ro.press = review_html.css("div.review_source div.media-body a.subtle").text
      # add this review to movie.reviews
      #movie_object.reviews << ro
      movie_object.add_review(ro)
    end

  end
end