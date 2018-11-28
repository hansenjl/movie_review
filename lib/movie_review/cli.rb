class MovieReview::CLI

  def start
    puts "Welcome to the Movie Review App!"
    puts "Here are the top 100 movies:"
    #scrape all the movies  - call to the scraper class
    #list the top 100 movies
    list_movies
    # ask for input
    list_review  # call another method

  end

  def list_movies
    MovieReview::Review.all.each.with_index(1) do |movie,index|
      puts "#{index}. #{movie.name}"
    end
  end

  list_review
     if movie's details have NOT been scraped,
          scrape



end