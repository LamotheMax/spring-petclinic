VAR=$(./jenkins/scripts/check_commit_age.sh)

echo $VAR
if [ $VAR == BREAK ]
then
mvn -B compile
fi