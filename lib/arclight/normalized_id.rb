# frozen_string_literal: true

module Arclight
  ##
  # A simple utility class to normalize identifiers
  # to be used around the application for linking
  class NormalizedId
    def initialize(id)
      @id = id || ''
    end

    def to_s
      normalize
    end

    private

    attr_reader :id

    def normalize
      id.strip.tr('.', '-')
    end
  end
end
