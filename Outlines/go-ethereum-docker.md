# Proposal: Developing DApps with Go Ethereum SDK and Docker

- Isolated and repeatable environments.
- Strictly controlled dependencies.
  - Forces you to be explicit about your dependencies.
  - Forces you to consciously manage dependency versions.
- Forces you to make sure that your application works in a pristine and neutral environment.
- Forces you to carefully consider user onboarding. If you have to jump through hoops to get your application working in a docker container, then you may have to reconsider how your user is going to get your application up and running.
- Keeps your local environment separate from your development environment.
- Allows you some measure of cross-platform testing: across linux versions, and if you are running Docker for Windows, some versions of Windows and Windows Server.
- Infrastructure as code. docker-compose.yml, or just run with shell scripts.
- especially useful if working on Windows, because:
    - can't compile the Go Ethereum SDK or solc on Windows without performing some gymnastics with MinGW-w64/MinGW to get GCC (64-bit) working and added to `$ENV:PATH`.
