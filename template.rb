# template.rb

  run "curl -OL https://gist.githubusercontent.com/scieslak/1292fb60b43bcc9b9bd3b8fe4f3e2c5c/raw/Gemfile"

  run "curl -OL https://gist.githubusercontent.com/scieslak/1292fb60b43bcc9b9bd3b8fe4f3e2c5c/raw/.travis.yml"

  # run "bundle && bundle outdated"

  run "mv config/database.yml config/database.example"

  append_file '.gitignore', "\n# Ignore database configuration.\nconfig/database.yml"

  create_file 'config/database.yml', <<-FILE
<% app_name = "#{app_name}" %>
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASS'] %>

development:
  <<: *default
  database: "<%= app_name + '_development' %>"

test:
  <<: *default
  database: "<%= app_name + '_test' %>"

production:
  <<: *default
  database: "<%= app_name + '_production' %>"
  FILE

  rails_command "db:create"

  run "guard init minitest"

  run "curl -OL https://gist.githubusercontent.com/scieslak/1292fb60b43bcc9b9bd3b8fe4f3e2c5c/raw/Guardfile"

  run "curl -o test/test_helper.rb -OL https://gist.githubusercontent.com/scieslak/1292fb60b43bcc9b9bd3b8fe4f3e2c5c/raw/test_helper.rb"

  run "curl -o vendor/assets/stylesheets/normalize.css -OL https://necolas.github.io/normalize.css/5.0.0/normalize.css"

  inject_into_file "app/assets/stylesheets/application.css", " *= require normalize\n", before: ' *= require_tree .'

  append_file '.gitignore', "\n\n# Ignore code coverage report.\n/coverage/*"

  # run 'rvm --ruby-version use 2.3.3@r233ror501'
  # run 'echo "\n# Ignore RVM configuration.\n.ruby*" >> .gitignore'

  git :init
  git add: '-A'
  git commit: "-m 'Initial commit'"

  run "atom ."
