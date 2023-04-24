# frozen_string_literal: true

require 'dry-schema'

module AppSettings
  class << self
    attr_reader :schema

    def define(&block)
      @schema = Dry::Schema.define(&block)
    end

    def load
      settings = config_for(:settings)
      override = Rails.root.join('config', 'settings_override.yml')
      settings.deep_merge!(config_for(:settings_override)) if override.exist?

      result = @schema.call(settings)
      if result.success?
        Rails.configuration.settings = result.to_h.freeze
      else
        handle_failure(result)
      end
    end

    def fetch(*keys)
      result = Rails.configuration.settings.dig(*keys)
      return result unless result.nil?
      raise "No config for path #{keys}" unless block_given?

      yield
    end

    private

    def error_messages(errors, indent = 0)
      case errors
      in Array
        errors.map { |e| "#{' ' * indent}#{e}" }
      in Hash
        errors.flat_map do |key, es|
          ["#{' ' * indent}#{key}:"] + error_messages(es, indent + 2)
        end
      end
    end

    # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods
    def handle_failure(result)
      errors = result.errors.to_h
      message =
        error_messages(errors)
          .push('Invalid configuration. Check config/settings.yml and config/settings_override.yml')
          .join("\n")
      abort(message)
    end
    # rubocop:enable Rails/DeprecatedActiveModelErrorsMethods

    def config_for(key)
      Rails.application.config_for(key) || {}
    end
  end
end
