module ActionView
  module Renderable
    # TODO: Local assigns should not be tied to template instance
    attr_accessor :locals

    # TODO: These readers should be private
    attr_reader :filename, :source, :handler

    def render
      prepare!
      @handler.render(self)
    end

    def method
      ['_run', @extension, @method_segment].compact.join('_').to_sym
    end

    private
      def prepare!
        unless @prepared
          @view.send(:evaluate_assigns)
          @view.current_render_extension = @extension

          if @handler.compilable?
            @handler.compile_template(self) # compile the given template, if necessary
          end

          @prepared = true
        end
      end
  end
end
