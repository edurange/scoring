require 'sinatra'

# run from points dir
get '/' do
  teams = {}
  Dir.foreach('/tmp/scoring/points') do |filename|
    next if filename == "." || filename == '..'
    score = File.read(filename).to_i
    team = filename.match(/Team_\d+/).to_s
    next if team.nil? || team == ""
    teams[team] = score
  end
  sorted = teams.sort_by { |k,v| -v }
  out = ""
  sorted.each do |team, points|
    out += "#{team}: #{points}\n"
  end
  out
end
