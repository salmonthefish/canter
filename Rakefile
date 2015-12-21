task :test => :compile

task :compile => 'lib/carat/parser.rb'

rule '.rb' => '.y' do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end
