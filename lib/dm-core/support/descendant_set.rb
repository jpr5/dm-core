module DataMapper
  class DescendantSet
    include Enumerable

    # Initialize a DescendantSet instance
    #
    # @param [#to_ary] descendants
    #   initialize with the descendants
    #
    # @api private
    def initialize(descendants = [])
      @descendants = descendants.to_ary
    end

    # Add a descendant
    #
    # @param [Module] descendant
    #
    # @return [DescendantSet]
    #   self
    #
    # @api private
    def <<(descendant)
      @descendants << descendant
      self
    end

    # Remove a descendant
    #
    # Also removes from all descendants
    #
    # @param [Module] descendant
    #
    # @return [DescendantSet]
    #   self
    #
    # @api private
    def delete(descendant)
      @descendants.delete(descendant)
      each do |d|
        next if equal?(descendants = d.descendants)
        descendants.delete(descendant)
      end
    end

    # Iterate over each descendant
    #
    # @yield [descendant]
    # @yieldparam [Module] descendant
    #
    # @return [DescendantSet]
    #   self
    #
    # @api private
    def each
      @descendants.each do |d|
        yield d
        next if equal?(descendants = d.descendants)
        descendants.each { |dd| yield dd unless dd.equal?(d) }
      end
      self
    end

    # Test if there are any descendants
    #
    # @return [Boolean]
    #
    # @api private
    def empty?
      @descendants.empty?
    end

  end # class DescendantSet
end # module DataMapper
