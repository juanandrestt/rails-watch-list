require 'json'
require 'open-uri'

puts "Fetching movies from TMDB..."

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]

puts "Creating movies..."

movies.first(20).each do |movie_data|
  Movie.create!(
    title: movie_data["title"],
    overview: movie_data["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data["poster_path"]}",
    rating: movie_data["vote_average"]
  )
end
