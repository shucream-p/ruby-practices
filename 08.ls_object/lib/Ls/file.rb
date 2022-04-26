# frozen_string_literal: true

module Ls
  class File
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def name_length
      @name.size
    end
  end
end
