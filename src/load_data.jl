using CSV, DataFrames

#load the dataset
df = CSV.read("/home/codebabe/Desktop/builds/weather_seattle/data/seattle-weather.csv",DataFrame)

#show the first 5 rows
println(first(df,5))

#summary statistics
println(describe(df))