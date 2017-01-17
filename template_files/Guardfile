guard :minitest, spring: "bin/rails test", all_on_start: false do

  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})

  # All tests trigered by test_helper.rb update
  watch(%r{^test/test_helper\.rb$}) { 'test' }

  # All tests trigered by fixtures update
  watch(%r{^test/fixtures/(.*)\.yml$}) { 'test' }

  # Tests trigered by model update
  watch(%r{^app/models/(?<name>.+)\.rb$}) do |m|
    any_test(m[:name], "models") +
    any_test(m[:name], "models/#{m[:name]}")
  end

end

#=============================================================================#

# Returns array of file names matching provided name and path
def any_test(match=nil, path=nil)
  match = "*" unless match
  path << "/" if path
  Dir.glob("test/#{path}*#{match}_test.rb")
end
