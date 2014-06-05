SRC_DOT_FILES = FileList["dot.*"]
DST_DOT_FILES = %w(
  .emacs.d
  .gitconfig
  .vim
  .vimrc
  .gvimrc
  .oh-my-zsh-custom
  .zshrc
  .zshenv
  .aliases
  .tmux.conf
  .proverc
  .global_gitignore
  .gemrc
  .agignore
  .ideavimrc
  .percol.d
).map {|f| "#{ENV['HOME']}/#{f}" }

file "#{ENV['HOME']}/.oh-my-zsh" do
  sh %(git clone https://github.com/robbyrussell/oh-my-zsh.git #{ENV['HOME']}/.oh-my-zsh)
end

rule /^#{ENV['HOME']}\/\..*$/ =>
  [ proc { |target| target.sub(/^#{ENV['HOME']}\/\./, ".") } ] do |task|
  sh %(ln -si "#{Rake.original_dir}/#{task.source}" "#{task.name}")
end

task :default => DST_DOT_FILES + ["#{ENV['HOME']}/.oh-my-zsh"]
