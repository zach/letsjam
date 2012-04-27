letsjam - Code Competition Utility for Ruby
====

A standard library for winning programming competitions in Ruby.

It provides the ability to customize input reading, and a filewatcher-compatible (https://github.com/thomasfl/filewatcher) test runner.

This gem is based on Endel Dreyer's googlecodejam gem.

Basic Usage
---

Install the gem:

	gem install letsjam
	
Create a solution class (see Solution Class below) that solves the fiendishly difficult problem cleverly. This step is left as an exercise to the reader, but .

Then, to execute your masterpiece, use 'letsjam run', specifying the source file, input file and output file:

	letsjam -s A.rb -i A-small-0.in -o A-small-0.out

You'll see the following output:

    Running...
    Output written in: "A-small-0.out"
    Finished in 0.000712ms.

Then you submit that output and get first place. Ruby for the win!

Solution Class
---

Create a solution class file in the current directory that looks like this:

	# This solution uses the 'letsjam' gem from https://github.com/zach/letsjam
	class A
	  def input(lines)
	    lines[1..-1] # simple input: each line is its own test case as a string
	  end

	  def run(data)
	    nil # if all cases return nil, testjam's tester does not generate an output file
	  end

	  def test
	    # run tests (in testing mode only)
	  end
	end

You should leave the first line or a similar reference in the code to let judges know you are using letsjam to run your solution. They should appreciate the uncluttered solution code as much as you do, but if they've never heard of letsjam they very well may assume you left some code out.

How letsjam Works
---

When you run letsjam, the program:

1. Loads the solution class you provide and creates an instance of it ("the instance of your solution class")
2. Reads the input file you provide into an array of strings
3. Calls the #input method of the instance of your solution class with that array as an argument
4. Receives an array of test cases as the return value of #input
5. Executes the #run method of the instance of your solution class once with each element of that array of test cases
6. Receives output for each test case as the return values of #run
7. Outputs the collected values from the calls to the #run method into a properly-formatted output file.

This way, you never need to even think about the mundane details of running your solution, and can focus on the essential problem.

Input Reading
---

Programming competition input is typically plain text, with a first line which declares the number of test cases to follow. This helps lesser programming languages preallocate things. Since you're using Ruby, feel free to ignore this line.

There are a few standard tropes to problem input. Here are a few and examples of how to handle them (you can start with these if you have a similar format):

[Warning: these have not been tested.]

1. Test cases of one line each containing a string (as shown above).

	    def input(lines)
	      lines.drop(1) # simple input: each line is its own test case as a string
	    end

2. Test cases of one line each containing only integers

	    def input(lines)
	      lines.drop(1).map{|s| s.split.map{|n| n.to_i}} # convert each case line to an array of integers
	    end

3. Test cases of one line each containing an integer and a string

	    def input(lines)
	      lines.drop(1).map do |line| # convert each line after
	        strs = line.split
	        [strs[0].to_i, strs[1].to_s]
		  end
	    end

3. Lines of two integers followed by a list of integers which is essentially an array

	    def read(lines)
	      lines.drop(1).map do |line|
	        strs = line.split
	        [strs[0].to_i, strs[1].to_i, strs.drop(2).map(&:to_i)]
	      end
	    end

4. Cases with one line indicating the number of lines to follow

	    def read(lines)
	      case_lines = []
	      sliced_lines = lines.drop(1) # get input without leading number of cases
	      case_lines.push(sliced_lines.slice!(0, sliced_lines.shift.to_i)) until sliced_lines.empty? # add strings for each line
		  case_lines
	    end

4. Cases with one line with several numbers, the first indicating the number of lines containing a string to follow

	    def read(lines)
	      case_data = []
	      sliced_lines = lines.drop(1) # get input without leading number of cases
	      until sliced_lines.empty? do
	        case_description = sliced_lines.shift.split
	        num_lines = case_description[0].to_i
	        other_num = case_description[1].to_i
	        case_data.push([other_num, sliced_lines.slice!(0, num_lines)])
	      end
		  case_data
	    end

5. A set of global data followed by a list of cases (here, we put the global data in instance variables)

	    def read(lines)
	      @letters, @num_words, @total_cases = lines.first.split.map(&:to_i)
	      @words = lines[1..@num_words]
	      lines[(@num_words+1)..-1] # rest of the lines are the test cases
		end

Continuous Testing Usage
---

Letsjam's test runner, when combined with filewatcher (https://github.com/thomasfl/filewatcher), allows you to get instant feedback on your solution for sample cases.

For instance, assuming you have a problem "A" with input and expected output for a sample:

1. Install filewatcher if not already installed:

	gem install filewatcher

2. Put the sample input into a file such as A-sample.in

3. Put the sample's expected output into a corresponding file, in this case A-sample.expected

4. Run filewatcher using the source file and letsjamtest so that every time the source file is changed on disk, it runs the test:

	filewatcher A.rb 'letsjamtest -s A.rb -i A-sample.in'

5. Leave that command running, write your solution with your favorite editor and every time you save, it will run the code instantly.

Limitations
---

This library is currently only truly intended to be useful for Google Code Jam.

The test comparator is limited to string identity, and so will not be useful on problems with a floating-point output.

The colorized output from the test runner embeds escape codes directly in a string instead of using the colorize gem.

TODO
---

- Add author's examples for various problems
- Use commander gem: https://github.com/visionmedia/commander
- Use colorize natively if installed
- Use filewatcher natively if installed
- Create progress bar for cases using commander
- Use unit test style output ("expected: '43' output: '44'"), using diffy for long outputs if installed
- letsjam generate A.rb => ./A.rb with A class
- letsjam generate src/A.rb => src/A.rb with A class
- letsjam generate src/foobar.rb => src/foobar.rb with Foobar class
- Supporting floating-point answers to within an epsilon (accepting floats that differ by less than 1e-6)
- InterviewStreet support (provide a few lines to paste at the end of a solution file to allow it to run unmodified on InterviewStreet)
- Contest log which shows times and even logs source for performance analysis - creates/uses-if-present letsjam-log or .letsjam-log directory
- JRuby multithreaded parallel test case running

License
---

This gem, including the code in this file, is distributed under the MIT license. Please see the LICENSE file.

Thanks
---

Thanks for checking out letsjam. I hope for the best for you in whatever competition you enter!

-- Zach.
