# Based on https://github.com/endel/googlecodejam
module LetsJam
  class Tester
    def self.compare(infile, outfile)
      input_lines = open(infile).readlines
      output_lines = open(outfile).readlines
      input_lines.zip(output_lines).each do |lines|
        input_line, output_line = lines
        # TODO: use permissive checking as typical online judges do
        return false if input_line.strip != output_line.strip
      end
      true
    end
  end
end