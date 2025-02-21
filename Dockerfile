# Use the official Julia image from Docker Hub
FROM julia:1.7

# Set the working directory inside the container
WORKDIR /app

# Copy your project files into the container
COPY . .

# Install dependencies and precompile packages
RUN julia -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'

# Ensure your app listens on the port provided by Render
# In your dashboard.jl, update the run command to:
# run_server(app, "0.0.0.0", parse(Int, get(ENV, "PORT", "8050")), debug=true)

# Start the application
CMD ["julia", "dashboard.jl"]
