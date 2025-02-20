using Dash, CSV, DataFrames, Dates, PlotlyJS

# Load the dataset
df = CSV.read("/home/codebabe/Desktop/builds/weather_seattle/data/seattle-weather.csv", DataFrame)
df.date = Date.(string.(df.date), dateformat"yyyy-mm-dd")

# Extract min and max year
min_year = minimum(year.(df.date))
max_year = maximum(year.(df.date))
unique_years = unique(year.(df.date))

println("Dataset loaded successfully! Date range: $min_year - $max_year")

# Initialize Dash app
app = dash()

# Layout
app.layout = html_div([
    html_h1("Seattle Weather Dashboard"),
    dcc_dropdown(
        id="year-dropdown",
        options=[(label=string(y), value=y) for y in unique_years],
        value=min_year
    ),
    dcc_graph(id="weather-graph"),
    dcc_slider(
        id="start-year-slider",
        min=min_year,
        max=max_year,
        value=min_year,
        marks=Dict(y => string(y) for y in unique_years),
        step=1
    ),
    dcc_slider(
        id="end-year-slider",
        min=min_year,
        max=max_year,
        value=max_year,
        marks=Dict(y => string(y) for y in unique_years),
        step=1
    )
])

# Callback for dropdown, sliders
callback!(app, Output("weather-graph", "figure"), 
          Input("start-year-slider", "value"), 
          Input("end-year-slider", "value"), 
          Input("year-dropdown", "value")) do start_year, end_year, selected_year
    
    start_year = Int(start_year)  # Ensure conversion to integer
    end_year = Int(end_year)  # Ensure conversion to integer
    
    filtered_df = filter(row -> start_year <= year(row.date) <= end_year, df)
    
    trace1 = scatter(x=filtered_df.date, y=filtered_df.temp_max, mode="lines", name="Max Temp")
    trace2 = scatter(x=filtered_df.date, y=filtered_df.temp_min, mode="lines", name="Min Temp")
    trace3 = scatter(x=filtered_df.date, y=filtered_df.precipitation, mode="lines", name="Precipitation", yaxis="y2")
    trace4 = scatter(x=filtered_df.date, y=filtered_df.wind, mode="lines", name="Wind Speed", yaxis="y3")

    layout = Layout(
        title="Weather Trends",
        xaxis_title="Date",
        yaxis=attr(title="Temperature (°C)"),
        yaxis2=attr(title="Precipitation (mm)", overlaying="y", side="right"),
        yaxis3=attr(title="Wind Speed (m/s)", overlaying="y", side="left", anchor="free", position=0.05),
        hovermode="x unified"
    )
    
    return plot([trace1, trace2, trace3, trace4], layout)
end

# Run server
run_server(app, "0.0.0.0", 8050, debug=true)
