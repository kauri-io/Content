= Code examples

Code examples are an essential part of developer documentation and help
a developer understand a conceot, and as they are often the only thing a
developer is looking for in your docs, they are essential to get right.

Pick and use a consistent example to build upon. While it’s near
impossible to address everyone’s nuanced use cases, using a consistent
example helps a reader compare what they are reading to a concrete use
case and read between the lines to apply to their use case.

Aside from absolute first steps, make examples realistic and follow best
practices for the language you are using. Overly simplified examples
deter a reader, and reduce how seriously they take your documentation. Pick an example that can show introductory steps, but scale up to show more complex topics. Again, this helps readers extrapolate what they need to know for their particular use case.

If you use long examples, consider adding comments to explain code lines
in case a reader doesn’t read (all) the explanation.

Test the code examples to see if they work, preferably on a different
machine or virtual machine to your own, to prevent assumed dependencies, and the dreaded "works for me" statement. Some markup languages specific to
documentation (not default markdown) allow you to embed lines from code
files directly into your rendered documentation, meaning you can write
a fully-functioning application that is testable. If that option
isn’t open to you, then manually or automatically test code examples as
often as possible. Remember that last time you found a code snippet that
didn’t work, and how frustrating it was, and ensure it doesn’t happen in
your docs.
