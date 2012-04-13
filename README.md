LetsJam - Code Competition Utility for Ruby
====

This is letsjam, a fork of the googlecodejam gem.  I hope to add some features for InterviewStreet to this version after Code Jam.

It provides the ability to customize input reading, and a filewatcher-compatible (https://github.com/thomasfl/filewatcher) test runner.

The original README appears below. Enjoy.

-- Zach.

Google Code Jam - Runner Utility for Ruby
====

Get the output of tour Google Code Jam algorithms even more easily with this gem.

How to use
---

Install the gem:

    gem install googlecodejam

Write a class to resolve single entries of the problem, like this:

    # reverse_words.rb
    class ReverseWords
      def run(line)
        line.split(' ').reverse.join(' ')
      end
    end

Run the utility by giving the source algorithm and input file (downloaded from Google Code Jam problem description)

    googlecodejam -s reverse_words.rb  -i B-small-practice.in

So you'll see the following output:

    Running...
    Output written in: "B-small-practice.out"
    Finished in 0.000712ms.

Have fun!

License
---

This gem is distributed under the MIT license. Please see the LICENSE file.
