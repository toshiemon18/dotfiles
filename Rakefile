# frozen_string_literal: true

require 'rake'
require 'logger'

# Rakeタスクから参照してもよいディレクトリ
DOTFILES_DIR = %w[git nvim].freeze

namespace :dotfiles do
  desc 'setup for dotfiles isntall'
  task :setup do
    logger.info('start dotfiles:setup')
    install_homebrew
  end

  namespace :setup do
    desc 'setup all components'
    task :all do
      logger.info('==== start dotifles:setup:all')
      Rake::Task['dotfiles:setup:git'].invoke
      Rake::Task['dotfiles:setup:nvim'].invoke
    end

    desc 'setup neovim files'
    task :nvim, %i[backup] do |_task, args|
      logger.info('==== start dotifles:setup:nvim')
      install_component('nvim',
                        distination_directory: "#{xdg_config_home}/nvim",
                        backup: !args[:backup].nil?)
    end

    desc 'setup git files'
    task :git, %i[backup] do |_task, args|
      logger.info('==== start dotfiles:setup:git')
      install_component('git', distination_directory: home_directory, backup: !args[:backup].nil?)
    end
  end
end

private

def exec_cmd(cmd)
  logger.info("[Running] #{cmd}")
  `#{cmd}` unless ENV['DEBUG']
end

# dotfiles以下のいずれかのディレクトリの中身をそのままコピーないしsymlinkを張る
# @param [String] directory_name コピー元のディレクトリ名
# @param [String] distination_directory コピー先のディレクトリ名
# @param [Symbol] method :symlink がデフォルト, それ以外を指定するとファイルコピーになる
# @param [Boolean] backup コピー先にファイルが存在する場合、バックアップを取るかどうか
def install_component(directory_name, distination_directory: nil, method: :symlink, backup: false)
  unless !DOTFILES_DIR.include?(distination_directory) && Dir.exist?(directory_name)
    return logger.warn("directory not found: #{directory_name}")
  end

  files = Dir.glob("#{directory_name}/*", File::FNM_DOTMATCH).reject { |path| path =~ /\.$/ }
  return logger.info("directory is empty: #{directory_name}") if files.empty?

  distination_base_dir = !distination_directory.nil? ? distination_directory : xdg_config_home
  unless Dir.exist?(distination_base_dir)
    logger.info("#{distination_base_dir} not found, creating directory")
    Dir.mkdir(distination_base_dir)
  end

  files.each do |file|
    filename = file.split('/').last
    source = "#{current_directory}/#{directory_name}/#{filename}"
    distination = "#{distination_base_dir}/#{filename}"

    logger.info('-----------------')
    logger.info(file.to_s)
    logger.info("source: #{source}")
    logger.info("distination: #{distination}")

    is_exists = File.exist?(distination) &&
                (!File.symlink?(distination) || (File.symlink?(distination) && File.readlink(distination) != source))
    if backup && is_exists
      logger.info("overwrite #{distination}, leaving backup file at #{distination}.bkup")
      exec_cmd(%( mv "#{distination}" "#{distination}.bkup" ))
    end

    cmd = if method == :symlink
            "ln -nfs #{source} #{distination}"
          else
            "cp -f #{source} #{distination}"
          end

    exec_cmd(cmd)
  end
end

def install_homebrew
  exec_cmd('which brew')
  return logger.info('brew is already installed.') if $?.success?

  logger.info('brew command not found, installing homebrew!')
  exec_cmd(%{bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"})
  exec_cmd('brew update')
  exec_cmd("brew bundle --file=#{current_directory}/Brewfile")
end

def logger
  Logger.new($stdout)
end

def current_directory
  ENV['PWD']
end

def home_directory
  ENV['HOME']
end

# XDG_CONFIG_HOMEが設定されている場合はその値を返す, ない場合は #$HOME/.config
def xdg_config_home
  ENV.fetch('XDG_CONFIG_HOME') { "#{home_directory}/.config" }
end
