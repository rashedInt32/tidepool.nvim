# frozen_string_literal: true

# Tidepool demo: Ruby
require "json"

module Tidepool
  MAX_HEIGHT = 4.2

  class OutOfRange < StandardError; end

  Reading = Struct.new(:station, :height, keyword_init: true) do
    def phase = height.positive? ? :rising : :falling

    def to_s
      format("%-6<station>s %<height>+.2fm", station:, height:)
    end
  end

  class Log
    include Enumerable

    attr_reader :unit

    def initialize(unit: "m")
      @unit = unit
      @entries = []
    end

    def <<(reading)
      raise OutOfRange, "#{reading.station}: #{reading.height}" if reading.height.abs > MAX_HEIGHT

      @entries << reading
      self
    end

    def each(&block) = @entries.each(&block)

    def to_json(*args)
      { unit: @unit, entries: @entries.map(&:to_h) }.to_json(*args)
    end
  end
end

log = Tidepool::Log.new
[["north", 1.5], ["south", -0.75], ["east", 9.0]].each do |station, height|
  log << Tidepool::Reading.new(station:, height:)
rescue Tidepool::OutOfRange => e
  warn "skipped #{e.message}" # TODO: collect
end

puts log.group_by(&:phase).transform_values(&:count).inspect
puts JSON.pretty_generate(log)
