# da-project-promo-50-modulo-2-team-3

useful files: 

1. data-retrieving_final.ipynb: to generate the sample and sending the data to SQL
2. music_trends.sql: to create the relationanal table in SQL
3. Data_music_consultas.sql: to run the querries to get the final tables

A company of music streaming (Music Streams) has contacted us to improve their users experience. They want to identify the changes in music trends based on music-genre and artist gender after the Covid-Pandemic, in order to tailor their music options to their users' tastes. In order to do that, we have extracted information from two different APIs, Spotify and LastFM. 

Since Spotify is the music streamer app with most users we extracted a sample of 24000 tracks that were published each year of our time-frame. The sample consists of 1000 tracks per genre per year, where we have 4 genres and six years. In this Database we have:
1. Track's name
2. Artist/band's name
3. Music Genre ('pop', 'urban', 'edm', 'rock')
4. Album's name
5. Release year (2019-2024)
6. Spotify ID (combination of numbers and letters)
7. Track's Popularity Index (From 0 to 100)

From LastFM we have extracted information specific to the artists that we have (all the artists have beed identified in both Databases - i.e. there is no missing data in this step). The final database named artists.csv contains this information related to the artist or band:
1. Artist's name
2. Artist's biography (text)
3. Listeners amount
4. Playcount
5. A list of similar artists

After obtainig the data we used the package MySQLAlchemy to transfer the final databasesinto SQL where we have worked with different querries to dissentangle the evolution of trends:
1. Changes based on years
2. Changes based on music-genres
3. Changes based on geographic origin of the artist/band
4. Changes based on artist's gender 
5. Idntification of the most popular music based on different indicators (4 different indicators)

ABOUT US
