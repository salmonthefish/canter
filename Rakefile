task :test => :compile

task :compile => 'lib/carat/parser.rb'

rule '.rb' => '.y' do |t|
  sh "racc -1 -o #{t.name} #{t.source}"
end
