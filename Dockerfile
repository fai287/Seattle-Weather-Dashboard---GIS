# Use an official Julia image as the base
FROM julia:1.9

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Install required Julia packages (including Dash)
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.add(["Dash", "Genie", "CSV", "DataFrames"])'

# Expose the port Dash.jl uses (default 8050) or Genie (8000)
EXPOSE 8050

# Start the Dash or Genie app
CMD ["julia", "dashboard.jl"]
