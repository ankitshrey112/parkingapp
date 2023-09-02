FROM ruby:3.0.0

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

EXPOSE 3000
EXPOSE 3306
EXPOSE 3307

CMD ["rails", "server", "-b", "0.0.0.0"]
