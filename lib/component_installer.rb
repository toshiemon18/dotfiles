# frozen_string_literal: true

require_relative "settings"

class ComponentInstaller
  def initialize(component_name, settings)
    @component_name = component_name
    @settings = settings
    @component = settings.get_component(component_name)
    @installed_components = Set.new
  end

  def install
    logger.info("Installing #{@component_name}...")
    check_dependencies
    install_component
    logger.info("Successfully installed #{@component_name}")
  rescue => e
    logger.error("Failed to install #{@component_name}: #{e.message}")
    raise e
  end

  private

  def check_dependencies
    @component.dependencies.each do |dep|
      next if @installed_components.include?(dep)

      logger.info("Installing dependency: #{dep}")
      installer = create_installer(dep)
      installer.install
      @installed_components.add(dep)
    end
  end

  def install_component
    source_dir = @component.source_dir
    destination = expand_path(@component.destination)
    method = @component.method.to_sym
    backup = @component.backup

    install_files(source_dir, destination, method, backup)
  end

  def install_files(source_dir, destination, method, backup)
    files = Dir.glob("#{source_dir}/*", File::FNM_DOTMATCH).reject { |path| path =~ /\.$/ }
    return logger.info("Directory is empty: #{source_dir}") if files.empty?

    ensure_destination_directory(destination)

    files.each do |file|
      filename = file.split("/").last
      source = "#{current_directory}/#{source_dir}/#{filename}"
      target = "#{destination}/#{filename}"

      logger.info("Installing file: #{filename}")
      install_file(source, target, method, backup)
    end
  end

  def install_file(source, target, method, backup)
    backup_file(target) if should_backup?(target, source) && backup

    cmd = if method == :symlink
      "ln -nfs #{source} #{target}"
    else
      "cp -f #{source} #{target}"
    end

    exec_cmd(cmd)
  end

  def should_backup?(target, source)
    File.exist?(target) &&
      (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
  end

  def backup_file(target)
    backup_path = "#{target}.bkup"
    logger.info("Backing up #{target} to #{backup_path}")
    exec_cmd(%(mv "#{target}" "#{backup_path}"))
  end

  def ensure_destination_directory(destination)
    return if Dir.exist?(destination)

    logger.info("Creating directory: #{destination}")
    begin
      Dir.mkdir(destination)
    rescue Errno::EACCES => e
      raise InstallError, "Failed to create directory: #{e.message}"
    end
  end

  def create_installer(component_name)
    self.class.new(component_name, @settings)
  end

  def exec_cmd(cmd)
    logger.info("[Running] #{cmd}")
    `#{cmd}` unless ENV["DEBUG"]
  end

  def logger
    Logger.new($stdout)
  end

  def current_directory
    ENV["PWD"]
  end

  def expand_path(path)
    path.gsub(/^~/, ENV["HOME"])
  end
end

class InstallError < StandardError; end
