class String
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  alias_method :each, :each_char

  # The inverse of <tt>String#include?</tt>. Returns +true+ if the string does
  # not contain +str+.
  def exclude?(str)
    !include? str
  end
  alias_method :excludes?, :exclude?

  # Left-aligns a heredoc by finding the lest indented line in the string, and
  # removing that amount of leading whitespace.
  #
  # For example, the following would print the contents of the heredoc as
  # described for each line.
  #
  #   puts <<-EOS.heredoc
  #     This line would be left-aligned.
  #     This line too.
  #         This line would be indented by four spaces.
  #         As well as this line.
  #     And back to left-aligned.
  #   EOS
  def heredoc
    gsub /^[ \t]{#{scan(/^[ \t]*(?=\S)/).min.size}}/, ""
  end
  alias_method :format_heredoc, :heredoc
  alias_method :strip_heredoc, :heredoc
end
