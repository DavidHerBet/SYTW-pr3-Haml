task :default => :rps

desc "Ejecutar rps en el servidor thin (puerto 9292)"
task :rps do
  sh "ruby rps.rb"
end

desc "Ejecutar el cliente con piedra"
task :rock do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?choice=rock'"
end

desc "Ejecutar el cliente con papel"
task :paper do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?choice=paper'"
end

desc "Ejecutar el cliente con tijeras"
task :scissors do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?choice=scissors'"
end
