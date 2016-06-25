def movie_url(partial_id)
  "http://www.omdbapi.com/?i=tt227#{partial_id}&plot=short&r=json"
end

def get_movie(url)
  res = Net::HTTP.get URI(url)
  JSON.parse res
end

def to_date(date_string)
  return if date_string == "N/A"

  Date.strptime(date_string, "%d %b %Y")
end

def populate(from, to)
  (from..to).each do |n|
    puts "#{n} - From: #{from} To: #{to}"

    @from = n + 1
    url = movie_url(n)
    movie = get_movie url
    imdb_id = url.slice!(/tt[0-9]+/)

    if movie["Response"] == "True"
      Movie.create({
        title: movie["Title"],
        storyline: movie["Plot"],
        imdb_link: "http://www.imdb.com/title/#{imdb_id}",
        release_date: to_date(movie["Released"]),
        genre_list: movie["Genre"]
      })
    end
  end
rescue Net::OpenTimeout => error
  puts "Rescuing of: #{error.message}"
  populate @from, ENV["seed_to"].to_i
end

populate(ENV["seed_from"].to_i, ENV["seed_to"].to_i)
