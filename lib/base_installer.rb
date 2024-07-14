# frozen_string_literal: true

class BaseInstaller
  # @param [String] @distination_dir コピー先のディレクトリ名
  # @param [Boolean] backup コピー先にファイルが存在する場合、バックアップを取るかどうか
  def initialize(distination_dir: nil, backup: false)
    @distination_dir = distination_dir
    @backup = backup
  end

  def install
    raise NotImplementedError
  end

  private

  def exec_cmd(cmd)
    logger.info("[running] #{cmd}")
    `#{cmd}` unless env['debug']
  end

  # dotfiles以下のいずれかのディレクトリの中身をそのままコピーないしsymlinkを張る
  # @param [String] directory_name コピー元のディレクトリ名
  # @param [Symbol] method :symlink がデフォルト, それ以外を指定するとファイルコピーになる
  def install_component(directory_name, method: :symlink)
    unless !DOTFILES_DIR.include?(@distination_dir) && Dir.exist?(directory_name)
      return logger.warn("directory not found: #{directory_name}")
    end

    files = Dir.glob("#{directory_name}/*", File::FNM_DOTMATCH).reject { |path| path =~ /\.$/ }
    return logger.info("directory is empty: #{directory_name}") if files.empty?

    distination_base_dir = !@distination_dir.nil? ? @distination_dir : xdg_config_home
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
end

