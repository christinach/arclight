# frozen_string_literal: true

module Blacklight
  ##
  # Blacklight icons - add support for aria-hidden = true attribute for accessibility
  class Icon
    attr_reader :icon_name
    ##
    # @param [String, Symbol] icon_name
    # @param [Hash] options
    # @param [String] classes additional classes separated by a string
    def initialize(icon_name, options)
      @icon_name = icon_name
      @classes = options[:class] if options[:class].present?
      @aria_hidden = options[:aria_hidden] if options[:aria_hidden].present?
    end

    ##
    # Returns the raw source, but you could extend this to add additional attributes
    # @return [String]
    def svg
      file_source
    end

    ##
    # @return [Hash]
    def options
      {
        class: classes,
        "aria-hidden": (true if @aria_hidden)
      }
    end

    ##
    # @return [String]
    def path
      "blacklight/#{icon_name}.svg"
    end

    ##
    # @return [String]
    def file_source
      raise Blacklight::Exceptions::IconNotFound, "Could not find #{path}" if file.blank?

      file.source.force_encoding('UTF-8')
    end

    private

    def file
      # Rails.application.assets is `nil` in production mode (where compile assets is enabled).
      # This workaround is based off of this comment: https://github.com/fphilipe/premailer-rails/issues/145#issuecomment-225992564
      (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset(path)
    end

    def classes
      " blacklight-icons #{@classes} ".strip
    end
  end
end
