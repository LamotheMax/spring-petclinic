git bisect start ${BROKEN} ${STABLE}
git bisect run mvn clean test
git bisect reset
