docker run -ti --rm -v $(pwd):/root ethereum/solc:0.5.2 --abi --bin /root/quiz/quiz.sol -o /root/build --overwrite

docker run -ti --rm -v $(pwd):/root ethereum/client-go:alltools-v1.8.20 abigen --abi=/root/build/Quiz.abi --bin=/root/build/Quiz.bin --pkg=quiz --out=/root/quiz/quiz.go
