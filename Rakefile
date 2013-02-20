SRC_DOT_FILES = FileList["dot.*"]
DST_DOT_FILES = SRC_DOT_FILES.gsub(/^dot\./, "#{ENV['HOME']}/\.")

rule /^#{ENV['HOME']}\/\..*$/ => 
  [ proc { |target| target.sub(/^#{ENV['HOME']}\/\./, "dot.") } ] do |task|
  sh %(ln -sF "#{Rake.original_dir}/#{task.source}" "#{task.name}")
end

task :default => DST_DOT_FILES
