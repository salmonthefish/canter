module Carat
  class Handler
    attr_reader :stack

    def initialize
      @stack  = [[:root]]
    end

    def start_object
      push [:hash]
    end

    def start_array
      push [:array]
    end

    def end_array
      @stack.pop
    end
    alias :end_object :end_array

    def pair(v1, v2)
      @stack.last << [:pair, v1, v2]
    end

    def name(s)
      @stack.last << [:name, s]
    end

    def result
      @stack
    end

    private

    def push(o)
      @stack.last << o
      @stack << o
    end
  end
end
