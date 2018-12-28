class MovieReview::CLI
  attr_accessor :sorted_movies

  def start
    greeting
    scrape_movies
    menu
  end

  def greeting
    puts "Welcome to the Movie Review App!"
  end


  def scrape_movies
    MovieReview::Scraper.scrape_movies
  end

  def menu
    puts "If you want to list movies alphabetically, type 'abc'"
    puts "If you want to list movies by rating, type 'rating'"
    puts "If you want to exit, type 'exit'"

    input = gets.strip.downcase

    case input
    when 'abc'
      sort_movies_abc
      list_movies
      get_movie_method_in_loop_format
    when 'rating'
      sort_movies_rating
      list_movies
      get_movie_method_in_loop_format
    when 'exit'
    else
      puts "Sorry I didn't understand that!"
      menu
    end
  end

  def sort_movies_abc
    @sorted_movies = MovieReview::Movie.all.sort_by{|movie| movie.title}
  end

  def sort_movies_rating
    @sorted_movies = MovieReview::Movie.all.reverse
  end

  def list_movies
    puts "Here are the top 100 movies:"
    @sorted_movies.each.with_index(1) do |movie,index|
      puts "#{index}. #{movie.title}"    # if index <= 100
    end
  end

  # def get_movie_method
  #     input = gets.strip   #"A Private War"   "exit"
  #     index =  input.to_i - 1
  #     if index.between?(0,99)   #a string will be -1
  #       movie = @sorted_movies[index]
  #       puts "#{movie.title}:"
  #       puts "Rotten Tomatoes was liked by #{movie.rating} of people "
  #       puts "#{movie.critic}"
  #       want_more_info(movie)

  #     elsif input == "exit"
  #         #allow this method to end
  #     else
  #       puts "Sorry! I didn't understand that command"
  #       get_movie_method   #recursion
  #     end
  # end

  def get_movie_method_in_loop_format
     puts "Choose a number that corresponds to a movie"
      input = gets.strip
      until input.to_i.between?(1,100) || input == "exit"
        puts "Sorry! I didn't understand that command!"
        input = gets.strip
      end
      if input != "exit"
        index =  input.to_i - 1
        movie = @sorted_movies[index]
        display_movie(movie)
        menu
      end
  end

  def display_movie(movie)
    puts "#{movie.title}:"
    puts "Rotten Tomatoes was liked by #{movie.rating} of people "
    puts "#{movie.critic}"
    want_more_info(movie)
    puts "Please select a movie you want more info about by choosing a number 1-100  or type 'exit' to Exit"
  end

  def want_more_info(movie)
    puts "Read more (Y/N)?"
    input = gets.strip.upcase
    until  ["Y","N","YES","NO"].include?(input)
      puts "Please type Y or N"
      input = gets.strip.upcase
    end
    if input == "Y" || input == "YES"
      puts "... fetching the reviews \n\n"
      # if any of the attributes that gets scraped the 2nd time is nil, then we should scrape
      MovieReview::Scraper.scrape_reviews(movie) if movie.reviews == []
      movie.reviews.each do |review|
        puts "#{review.author} from the #{review.press} says #{review.quote}.\n\n"
      end
    else
      puts "you ended"
    end
  end

end