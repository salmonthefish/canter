module Carat
  class Handler
    attr_reader :stack

    def initialize
      @stack  = [[:root]]
    end

    def start_object
      push [:hash]
    end

    def end_object
      @stack.pop
    end

    def pair(v1, v2)
      @stack.last << [:pair, v1, v2]
    end

    def name(s)
      @stack.last << [:name, s]
    end

    def group_name(n1, n2)
      @stack.last << [:group_name, n1, n2]
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
