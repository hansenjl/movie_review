class MovieReview::CLI
  attr_accessor :sorted_movies

  def start
    puts "Welcome to the Movie Review App!"
    puts "Here are the top 100 movies:"
    MovieReview::Scraper.scrape_movies
    sort_movies
    #scrape all the movies  - call to the scraper class
    #list the top 100 movies
    list_movies
    puts "Please select a movie you want more info about by choosing a number 1-100"
    get_movie_method_in_loop_format  #asked for input and reported a 'teaser'


    # ask for input
    #list_review  # call another method
  end

  def sort_movies
    @sorted_movies = MovieReview::Movie.all.sort_by{|movie| movie.title}
  end

  def list_movies
    @sorted_movies.each.with_index(1) do |movie,index|
      puts "#{index}. #{movie.title}"    # if index <= 100
    end
  end

  def get_movie_method
      input = gets.strip   #"A Private War"   "exit"
      index =  input.to_i - 1
      if index.between?(0,99)   #a string will be -1
        movie = @sorted_movies[index]
        puts "#{movie.title}:"
        puts "Rotten Tomatoes was liked by #{movie.rating} of people "
        puts "#{movie.critic}"
        want_more_info(movie)
      elsif input == "exit"
          #allow this method to end
      else
        puts "Sorry! I didn't understand that command"
        get_movie_method   #recursion
      end
  end

  def get_movie_method_in_loop_format
      input = gets.strip
      until input.to_i.between?(1,100) || input == "exit"
        puts "Sorry! I didn't understand that command!"
        input = gets.strip
      end
      if input != "exit"
        index =  input.to_i - 1
        movie = @sorted_movies[index]
        puts "#{movie.title}:"
        puts "Rotten Tomatoes was liked by #{movie.rating} of people "
        puts "#{movie.critic}"
        want_more_info(movie)
      end
  end

  def want_more_info(movie)
    puts "Read more (Y/N)?"
    input = "nil"
    input = gets.strip.upcase
    until input == "Y" || input == "N" || input == "YES" || input == "NO"
      puts "please enter YES or NO"
      input = gets.strip.upcase
    end
    if input == "Y" || input == "YES"
      puts "... fetching reviews for #{movie.title}\n\n"
      MovieReview::Scraper.scrape_reviews(movie) #scrape reviews
      puts "Critic Reviews for #{movie.title}:\n\n"
      movie.reviews.each do |rev|
        puts "#{rev.author} from the #{rev.press} says: #{rev.quote}\n\n"
      end

    else
      puts "you ended"
    end
  end



end