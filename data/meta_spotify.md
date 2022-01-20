# Meta Spotify

## Metadata Spotify
This is a data description file that explains each variable in the dataset. The content is adapted from the [R Data Anlaysis Workshop](https://github.com/GC-DRI/r_data_analysis_2021) by [Connor French](https://github.com/connor-french). 

If you are interested in Spotify Tracks Database, go and check this [dataset](https://www.kaggle.com/zaheenhamidani/ultimate-spotify-tracks-db) on Kaggle.
This [link](https://developer.spotify.com/documentation/web-api/reference/#/operations/get-audio-features) explains the Tracks's Audio Feature from Spotify API in detail. 

### AudioFeaturesObject

##### acousticness  
A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.	
Data type: Float  

##### danceability
Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.
Data type: Float  

##### duration_ms
The duration of the track in milliseconds.	
Data type: Integer  

##### energy
Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy.	
Data type: Float

##### instrumentalness
Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.	
Data type: Float  

##### key
The key the track is in. Integers map to pitches using standard Pitch Class notation . E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on.	
Data type: Integer  

##### liveness
Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.	
Data type: Float

##### loudness
The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db.	
Data type: Float

##### mode
Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. 
Data type: Character

##### speechiness
Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks.	
Data type: Float  

##### tempo
The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.	Data type: Float  

##### time_signature
An estimated overall time signature of a track. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure).	
Data type: Integer  

##### valence
A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).	
Data type: Float


### Other variables

##### track
The name of the song

##### artist
The name of the artist

##### rank
The Billboard ranking for each track for the specified time period. 

##### time_period
Time period of each Billboard 200 chart. They are relative to the present COVID pandemic.  

* pre = pre-COVID, week of March 16, 2019
* early = time when COVID officially spread to all 50 states, week of March 14, 2020
* first = the first peak in COVID deaths, week of April 25, 2020
* current = the time when I collected this data (also the largest peak in covid cases/deaths to date), week of January 30, 2021

