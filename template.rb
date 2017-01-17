# RAILS_TEMPLATE
# This is Ruby on Rails application template

# USAGE
# To initialize new app with rails_template run:
#
#   rails new <app_name> -d postgresql --skip-bundle -m <template_location>


# -------------------- GEMS ---------------------------------------------
# Copy prebuild Gemfile form template_files
run "cp #{File.dirname(path)}/template_files/Gemfile ."

## Run "bundle" after overriding default Gemfile
# run "bundle"

## Run "bundle outdated" to verify gems are up to date
# run "bundle outdated"


# -------------------- DATABESE -----------------------------------------
## To avoid security issues "database.yml" needs to be hidden
## from the remote repository by adding the file name to .gitignore.
append_file '.gitignore', "\n# Ignore database configuration.\nconfig/database.yml"

## Rename the original "database.yml" file to "database.example"
## to leave as a reference for anyone viewing the repository.
run "mv config/database.yml config/database.example"

## Create new "database.yml" with valid database credentilas.
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

# Create new database
rails_command "db:create"


# -------------------- TEST ---------------------------------------------
## Initiate Guard
run "guard init minitest"

## Replace the original "Guardfile"
run "cp #{File.dirname(path)}/template_files/Guardfile ."

## Replace the original "test_helper.rb"
run "cp #{File.dirname(path)}/template_files/test_helper.rb ./test/test_helper.rb"

## Add SimpleCov coverage report to "Gitignore".
append_file '.gitignore', "\n\n# Ignore code coverage report.\n/coverage/*"

## Copy prebuild .travis.yml form template_files
run "cp #{File.dirname(path)}/template_files/.travis.yml ."


# -------------------- CSS ----------------------------------------------
## Download "normalize.css" to the vendor stylesheets
run "curl -o vendor/assets/stylesheets/normalize.css -OL https://necolas.github.io/normalize.css/5.0.0/normalize.css"

## Add "*= require normalize" to "application.css"
inject_into_file "app/assets/stylesheets/application.css", " *= require normalize\n", before: ' *= require_tree .'

# -------------------- RVM ----------------------------------------------

## Create RVM configuration files.
# run 'rvm --ruby-version use 2.3.3@r233ror501'
# run 'echo "\n# Ignore RVM configuration.\n.ruby*" >> .gitignore'

# -------------------- GIT ----------------------------------------------
git :init
git add: '-A'
git commit: "-m 'Initial commit'"

# -------------------- EDITOR
run "atom ."
