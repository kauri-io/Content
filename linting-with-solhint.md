# Linting Smart Contracts with Solhint

I am a big fan of linting, the process of getting best-practise recommendations on your code, or even (my personal favorite), English language.

There are two options available for linting smart contract code style written in Solidity, solhint and xx. With my work as technical writer for the Solidity team, we wanted to check that all code examples conform to the style guide we define, and opted to use solhint because yyy. In this tutorial I walk through how we setup and configured solhint to do this, plus the CI side that checks all code examples on every pull request.

The Solidity documentation uses Sphinx and restructured text, which means that all code blocks are indented with 4 spaces, so first we have a Python script that looks for that syntax and extracts the relevant lines. However, there are some partial examples, or code in other languages we don't want to lint, so we use this line to only extract code that begins with a certain Solidity keyword.

```python
# Contract sources are indented by 4 spaces.
# Look for `pragma solidity`, `contract`, `library` or `interface`
# and abort a line not indented properly.
def extract_docs_cases(path):
    inside = False
    extractedLines = []
    tests = []

    # Collect all snippets of indented blocks
    for l in open(path, 'rb').read().splitlines():
        if l != '':
            if not inside and l.startswith(' '):
                # start new test
                extractedLines += ['']
            inside = l.startswith(' ')
        if inside:
            extractedLines[-1] += l + '\n'

    codeStart = "(pragma solidity|contract.*{|library.*{|interface.*{)"

    # Filter all tests that do not contain Solidity or are intended incorrectly.
    for lines in extractedLines:
        if re.search(r'^\s{0,3}' + codeStart, lines, re.MULTILINE):
            print("Intendation error in " + path + ":")
            print(lines)
            exit(1)
        if re.search(r'^\s{4}' + codeStart, lines, re.MULTILINE):
            tests.append(lines)

    return tests
```

With the code examples extracted, we can test them  in a variety of ways, including code style.

solhint uses a _.solhint.json_ config file to customise the styles you want to check for, and any plugins you want to use.

Here's the config file we use:

<!-- More -->

```json
{
    "extends": "solhint:default",
    "plugins": [],
    "rules": {
        "compiler-fixed": "off",
        "no-inline-assembly": "off"
    }
}
```

<!-- Format -->

The other file used for config is _.solhintignore_ that defines which files solhint should ignore while linting. As the Solidity _contributing.rst_ file contains examples of intentionally bad style, or broken code, we don't want to check the examples in it.

```text
*contributing_rst*
```

As the Solidity tests extract the code examples into a temporary directory we need to copy the config files above into that temporary directory. The Python script below does this, and also checks to see if the solhint npm package is installed, and installs it if not. The whole process stops completely if node is not installed. It  also runs the _isolate_tests.py_ script which extracts the code examples as detailed above:

```python
printTask "Checking docs examples style"
SOLTMPDIR=$(mktemp -d)
(
    set -e
    cd "$SOLTMPDIR"
    "$REPO_ROOT"/scripts/isolate_tests.py "$REPO_ROOT"/docs/ docs

    if npm -v >/dev/null 2>&1; then
        if npm list -g | grep solhint >/dev/null 2>&1; then
            echo "node is installed, setting up solhint"
            cp "$REPO_ROOT"/test/.solhint.json "$SOLTMPDIR"/.solhint.json
            cp "$REPO_ROOT"/test/.solhintignore "$SOLTMPDIR"/.solhintignore

            for f in *.sol
            do
                echo "$f"
                # Only report errors
                solhint -f unix "$SOLTMPDIR/$f"
            done
        else
            echo "node is installed, but not solhint"
            exit 1
        fi
    else
        echo "node not installed, skipping docs style checker"
        exit 1
    fi
)
rm -rf "$SOLTMPDIR"
echo "Done."
```
