# frozen_string_literal: true

require "yaml"
require "pathname"

class Settings
  REQUIRED_FIELDS = %w[source_dir destination method backup description dependencies].freeze
  VALID_METHODS = %w[symlink copy].freeze

  attr_reader :components

  def initialize(path = nil)
    @path = path || ENV["DOTFILES_SETTINGS_PATH"] || "settings.yml"
    load_settings
  end

  def get_component(name)
    @components[name.to_s]
  end

  private

  def load_settings
    @components = YAML.load_file(@path)["components"]
    validate_settings
  rescue Psych::SyntaxError => e
    raise SettingsError, "Invalid YAML syntax: #{e.message}"
  rescue Errno::ENOENT
    raise SettingsError, "Settings file not found: #{@path}"
  end

  def validate_settings
    @components.each do |name, component|
      validate_required_fields(name, component)
      validate_method(name, component)
      validate_paths(name, component)
    end
  end

  def validate_required_fields(name, component)
    missing_fields = REQUIRED_FIELDS - component.keys
    return if missing_fields.empty?

    raise SettingsError, "Missing required fields for component '#{name}': #{missing_fields.join(', ')}"
  end

  def validate_method(name, component)
    return if VALID_METHODS.include?(component["method"])

    raise SettingsError, "Invalid method for component '#{name}': #{component['method']}"
  end

  def validate_paths(name, component)
    source_dir = component["source_dir"]
    unless Dir.exist?(source_dir)
      raise SettingsError, "Source directory not found for component '#{name}': #{source_dir}"
    end

    destination = expand_path(component["destination"])
    parent_dir = File.dirname(destination)
    unless Dir.exist?(parent_dir)
      raise SettingsError, "Parent directory of destination not found for component '#{name}': #{parent_dir}"
    end
  end

  def expand_path(path)
    path.gsub(/^~/, ENV["HOME"])
  end
end

class SettingsError < StandardError; end
