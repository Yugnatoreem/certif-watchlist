puts "Cleaning database..."
sleep(2)
List.destroy_all
Movie.destroy_all

require 'open-uri'
require 'json'

url = "https://tmdb.lewagon.com/movie/top_rated"
serialized_file = URI.open(url).read
file = JSON.parse(serialized_file)
file["results"].each do |result|
  Movie.create(
    title: result["title"],
    overview: result["overview"],
    rating: result["vote_average"],
    poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}"
  )
  puts "created #{result["title"]}"
end
list_one = List.create(name: "The best movie")
list_two = List.create(name: "All good movies")
Bookmark.create(movie: Movie.first, list: list_one, comment: "testtest")
Bookmark.create(movie: Movie.last, list: list_one, comment: "testtest")
Bookmark.create(movie: Movie.last, list: list_two, comment: "testtest")
