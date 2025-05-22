require 'json'
require 'open-uri'

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]

Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Creating movies..."

movies.first(20).each do |movie_data|
  Movie.create!(
    title: movie_data["title"],
    overview: movie_data["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data["poster_path"]}",
    rating: movie_data["vote_average"]
  )
end
