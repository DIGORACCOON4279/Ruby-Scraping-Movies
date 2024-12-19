# require 'nokogiri'
# require 'open-uri'

# accion = "accion"
# # URL de la página a hacer scraping
# url = "https://www.themoviedb.org/search?query=#{accion}"

# # Abrir la página web
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML.parse(html_file)

# # doc = Nokogiri::HTML(URI.open(url))

# # Verifica si el documento se ha cargado correctamente
# puts "Cargando página... #{url}"

# # Inicializa arrays para almacenar la información
# titles = []
# images = []
# release_dates = []
# descriptions = []

# # Extraer los títulos de las películas
# html_doc.css('.card .title h2').each do |movie|
#   title = movie.text.strip
#   titles << title  # Almacena el título en el array
# end

# # Extraer las imágenes de las películas
# html_doc.css('.card .poster img').each do |image|
#   img_src = image['src']
#   images << img_src  # Almacena la URL de la imagen en el array
# end

# # Extraer las fechas de lanzamiento
# html_doc.css('.release_date').each do |release|
#   release_date = release.text.strip
#   release_dates << release_date  # Almacena la fecha de lanzamiento en el array
# end

# # Extraer las descripciones
# html_doc.css('.overview p').each do |overview|
#   description = overview.text.strip
#   descriptions << description  # Almacena la descripción en el array
# end

# # Ahora imprime los resultados en el orden deseado
# puts "Datos extraídos con éxito:"
# titles.each_with_index do |title, index|
#   # Imprimir los datos de cada película
#   puts "Título: #{title}"
#   puts "Imagen: #{images[index]}" if images[index]
#   puts "Fecha de lanzamiento: #{release_dates[index]}" if release_dates[index]
#   puts "Descripción: #{descriptions[index]}" if descriptions[index]
#   puts "------------------------------------"
# end

# # Crear archivo HTML con los resultados
# File.open('index.html', 'w') do |file|
#   file.puts "<html><body><h1>Películas de Acción</h1><ul>"

#   titles.each_with_index do |title, index|
#     file.puts "<li><strong>Título:</strong> #{title}</li>"
#     file.puts "<li><strong>Imagen:</strong> <img src='#{images[index]}' alt='Imagen de película'></li>" if images[index]
#     file.puts "<li><strong>Fecha de lanzamiento:</strong> #{release_dates[index]}</li>" if release_dates[index]
#     file.puts "<li><strong>Descripción:</strong> #{descriptions[index]}</li>" if descriptions[index]
#   end

#   file.puts "</ul></body></html>"
# end

# puts "Datos guardados en index.html"

# /----------------------------------------------------------------------------------------------/

require 'nokogiri'
require 'open-uri'


pelicula = "terror"
categoria = "tv"

# URL de la página a hacer scraping
url = "https://www.themoviedb.org/search/#{categoria}?query=#{pelicula}"

# Abrir la página web
doc = Nokogiri::HTML(URI.open(url))

# Verifica si el documento se ha cargado correctamente
puts "Cargando página... #{url}"

# Inicializa arrays para almacenar la información
titles = []
images = []
release_dates = []
descriptions = []

# Extraer los títulos de las películas
doc.search('.card .title h2').each do |movie|
  title = movie.text.strip
  titles << title  # Almacena el título en el array
end

# Extraer las imágenes de las películas
doc.search('.card .poster img').each do |image|
  img_src = image['src']
  images << img_src  # Almacena la URL de la imagen en el array
end

# Extraer las fechas de lanzamiento
doc.search('.release_date').each do |release|
  release_date = release.text.strip
  release_dates << release_date  # Almacena la fecha de lanzamiento en el array
end

# Extraer las descripciones
doc.search('.overview p').each do |overview|
  description = overview.text.strip
  descriptions << description  # Almacena la descripción en el array
end

# Crear archivo HTML con los resultados
File.open('index.html', 'w') do |file|
  file.puts <<-HTML
  <html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Películas</title>
     <!-- CSS -->
     <link rel="stylesheet" href="style.css">
     <!-- Google fonts -->
     <link rel="preconnect" href="https://fonts.googleapis.com">
     <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
     <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
  </head>
  <body>

  <section class="movies-section">
    <h1>Películas</h1>
    <section class="movies-container">
  HTML

  titles.each_with_index do |title, index|
    # Verificar si la tarjeta tiene datos válidos
    if title.to_s.strip.empty? || images[index].to_s.strip.empty? || release_dates[index].to_s.strip.empty? || descriptions[index].to_s.strip.empty?
      puts "No hay datos para esta película. Se omite."
    else
      file.puts <<-HTML

        <div class="movie-card">
          <img src="#{images[index]}" alt="Imagen de la película">
          <div class="details">
            <h4>#{title}</h4>
            <p class="release_date">Fecha de lanzamiento: <span>#{release_dates[index]}</span></p>
            <p class="description"><strong>Descripción:</strong> #{descriptions[index]}</p>
          </div>
        </div>
        HTML
    end
  end

  file.puts <<-HTML
    </section>
    </section>
  </body>
  </html>
  HTML
end

puts "Datos guardados en index.html"
