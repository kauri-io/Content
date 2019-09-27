# Linting Smart Contracts with Solhint

I am a big fan of linting, the process of getting best-practise recommendations on your code, or even (my personal favorite), English language.

There are two options available for linting smart contracts written in Solidity, solhint and xx. With my work as technical writer for the Solidity team, we wanted to check that all code examples conform to the style guide we define, and opted to use solhint because yyy. In this tutorial I walk through how we setup and configured solhint to do this, plus the CI side that checks all code examples on every pull request.

The Solidity documentation uses Sphinx and restructured text, which means that all code blocks are indented with 4 spaces, so first we have a script that looks for that syntax and extracts the relevant lines. However, there are some partial examples, or code in other laguages we don't want to lint, so we use this line to only extract code that begins with a certain Solidity keyword.

```python
if re.search(r'^    [ ]*(pragma solidity|contract |library |interface )', test, re.MULTILINE)
```
