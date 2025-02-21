
Seattle Weather Dashboard

Overview

This project is an interactive web-based dashboard built with Julia, Dash, PlotlyJS, and DataFrames. It visualizes Seattle weather data, including temperature, precipitation, and wind speed trends over time. Users can filter data by selecting a year range and interact with the plots dynamically.

Features

Interactive visualization of Seattle weather data.

Dropdown menu to select a specific year.

Sliders to adjust the start and end years for analysis.

Line charts displaying max/min temperature, precipitation, and wind speed.

Hover interaction for detailed insights.

Requirements

Ensure you have Julia installed and the following Julia packages:
using Pkg
Pkg.add(["Dash", "CSV", "DataFrames", "Dates", "PlotlyJS"]


Dataset:
link:https://www.kaggle.com/code/markmedhat/weather-seattle/input
Ensure the dataset includes at least the following columns:

date: The date of observation.

temp_max: Maximum recorded temperature.

temp_min: Minimum recorded temperature.

precipitation: Recorded precipitation.

wind: Recorded wind speed.



Running the Dashboard

After cloning the application;
Navigate to the project directory:
Run the Julia script:
julia dashboard.jl

Once running ,open your browser and go to:
http://localhost:8050

Modifying the Code

To change the dataset path, modify the CSV.read function in dashboard.jl.

To add new visualizations, update the callback! function with additional traces.

To customize the layout, modify app.layout to include additional UI components.


Troubleshooting

If you encounter a dcc_rangeSlider not defined error, ensure you are using dcc_slider instead.

If the dashboard does not load, check for missing dependencies and install them with Pkg.add().

If the dataset is not loading, verify that the file exists at the specified path.

License

This project is open-source. Feel free to modify and improve it!


















