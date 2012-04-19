# Based on https://github.com/endel/googlecodejam
module LetsJam
  class Runner
    def initialize(options={})
      instance = self.initialize_from_path(options[:source])

      test_cases = read(instance, IO.read(options[:input]).split($/))
      options[:output] ||= options[:input].gsub('.in', ".out")

      if test_cases.nil?
        raise "No test cases read!"
      else
        # run test method if present and in testing mode (:expected_output option is present)
        instance.test if options[:expected_output] and instance.respond_to?(:test)

        output = test_cases.each_with_index.inject("") do |r, (test_case_data, i)|
          begin
            r + (i+1==1 ? "" : "\n") + "Case ##{i+1}: #{instance.run(test_case_data)}"
          rescue => e
            puts e.backtrace
            raise "Test case data: #{test_case_data.inspect}"
          end
        end.strip

        File.open(options[:output], 'w+') {|f| f.write(output) }
      end
      options
    end

    protected
      def read(instance, input_lines)
        if instance.respond_to?(:read)
          # use problem-specific read routine
          instance.read(input_lines)
        else
          # use generic read routine (fine for one-line test cases)
          input_lines[1..-1]
        end
      end

      def initialize_from_path(path)
        full_path = File.expand_path(path)
        raise "'#{full_path}' not found." unless require full_path
        filename = File.basename(path, File.extname(path))
        klass_name = filename.split('_').map {|w| w.capitalize}.join

        if Object.const_get(klass_name)
          klass = Object.const_get(klass_name)
        end rescue nil

        if klass
          instance = klass.new
          raise "#{instance.name} must implement #run method." unless instance.respond_to?(:run)
          instance
        else
          puts "Error: '#{path}' is expected to define '#{klass_name}'"
          abort
        end
      end
  end
end
