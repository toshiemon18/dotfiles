# frozen_string_literal: true

require "rake"
require "logger"
require_relative "lib/settings"
require_relative "lib/component_installer"

namespace :dotfiles do
  desc "setup for dotfiles install"
  task :setup do
    logger.info("start dotfiles:setup")
    install_homebrew
  end

  namespace :setup do
    desc "setup all components"
    task :all do
      logger.info("==== start dotifles:setup:all")
      install_homebrew
      settings = Settings.new
      settings.components.keys.each do |component|
        Rake::Task["dotfiles:setup:#{component}"].invoke
      end
    end

    desc "setup git files"
    task :git, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:git")
      settings = Settings.new
      ComponentInstaller.new("git", settings).install
    end

    desc "setup neovim files"
    task :nvim, %i[backup] do |_task, args|
      logger.info("==== start dotifles:setup:nvim")
      settings = Settings.new
      ComponentInstaller.new("nvim", settings).install
    end

    desc "setup zsh"
    task :zsh, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:zsh")
      settings = Settings.new
      ComponentInstaller.new("zsh", settings).install
    end

    desc "setup tmux"
    task :tmux, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:tmux")
      settings = Settings.new
      ComponentInstaller.new("tmux", settings).install
    end

    desc "setup sheldon"
    task :sheldon, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:sheldon")
      settings = Settings.new
      ComponentInstaller.new("sheldon", settings).install
    end

    desc "setup vim"
    task :vim, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:vim")
      settings = Settings.new
      ComponentInstaller.new("vim", settings).install
    end

    desc "setup ghostty"
    task :ghostty, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:ghostty")
      settings = Settings.new
      ComponentInstaller.new("ghostty", settings).install
    end

    desc "setup mise"
    task :mise, %i[backup] do |_task, args|
      logger.info("==== start dotfiles:setup:mise")
      settings = Settings.new
      ComponentInstaller.new("mise", settings).install
    end
  end

  private

  def exec_cmd(cmd)
    logger.info("[Running] #{cmd}")
    `#{cmd}`
