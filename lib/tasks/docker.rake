# frozen_string_literal: true

namespace :docker do
  desc 'build docker images'
  task build: :environment do
    puts 'Building: clementines-dashboard'
    puts `docker build -t clementines-dashboard .`
  end
end
