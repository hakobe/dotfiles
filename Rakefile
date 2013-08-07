SRC_DOT_FILES = FileList["dot.*"]
DST_DOT_FILES = %w(
  .emacs.d
  .gitconfig
  .vim
  .vimrc
  .zshrc
  .aliases
  .tmux.conf
).map {|f| "#{ENV['HOME']}/#{f}" }

rule /^#{ENV['HOME']}\/\..*$/ => 
  [ proc { |target| target.sub(/^#{ENV['HOME']}\/\./, ".") } ] do |task|
  sh %(ln -sF "#{Rake.original_dir}/#{task.source}" "#{task.name}")
end

file "#{ENV['HOME']}/.gitignore" => "dot.gitignore" do |task|
  sh %(ln -sF "#{Rake.original_dir}/dot.gitignore" "#{task.name}")
end

task :default => DST_DOT_FILES + [ "#{ENV['HOME']}/.gitignore" ]
