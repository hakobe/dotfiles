SRC_DOT_FILES = FileList["dot.*"]
DST_DOT_FILES = %w(
  .emacs.d
  .gitconfig
  .vim
  .vimrc
  .gvimrc
  .zshrc
  .zshenv
  .aliases
  .tmux.conf
  .proverc
  .global_gitignore
  .gemrc
).map {|f| "#{ENV['HOME']}/#{f}" }

rule /^#{ENV['HOME']}\/\..*$/ => 
  [ proc { |target| target.sub(/^#{ENV['HOME']}\/\./, ".") } ] do |task|
  sh %(ln -sF "#{Rake.original_dir}/#{task.source}" "#{task.name}")
end

task :default => DST_DOT_FILES
