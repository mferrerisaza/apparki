# Dockerfile for Rails 5.1 with Webpacker
FROM ruby:2.4.4

# Fix Debian Stretch EOL - use archive repositories
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# Install system dependencies first (including lsb-release for NodeSource)
RUN apt-get update -qq && \
    apt-get install -y --allow-unauthenticated \
      curl \
      gnupg \
      apt-transport-https \
      lsb-release \
      postgresql-client \
      build-essential && \
    rm -rf /var/lib/apt/lists/*

# Manually add NodeSource repository for Node.js 9.x (required by upath dependency)
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/node_9.x stretch main" > /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/node_9.x stretch main" >> /etc/apt/sources.list.d/nodesource.list

# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Install Node.js and Yarn
RUN apt-get update -qq && \
    apt-get install -y --allow-unauthenticated nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /rails

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle update mimemagic && bundle install

# Install JavaScript dependencies
COPY package.json yarn.lock ./
# Pre-download the problematic large package using npm (which has better caching/mirrors)
RUN npm install --no-save material-design-icons@3.0.1
# Then install everything with yarn
RUN yarn install --check-files

# Copy application code (but preserve the updated Gemfile.lock)
COPY . .
# Restore the updated Gemfile.lock from the bundle update step
RUN bundle update mimemagic

# Precompile assets with dummy SECRET_KEY_BASE
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile RAILS_ENV=production

# Expose port
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
