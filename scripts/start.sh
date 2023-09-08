#!/bin/bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh # 여기서도 profile.sh 함수를 사용

REPOSITORY=/home/ec2-user/app
PROJECT_NAME=spring_deploy_test

echo "> Build 파일 복사"
echo "> cp $REPOSITORY/build/libs/*.jar $REPOSITORY/"

cp $REPOSITORY/build/libs/*.jar $REPOSITORY/

echo "> 새 애플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"

IDLE_PROFILE=$(find_idle_profile)

echo "> $JAR_NAME 를 profile=$IDLE_PROFILE로 실행합니다."
#  -Dspring.config.location=classpath:/application.yml, classpath:/application-$IDLE_PROFILE.yml \
nohup java -jar \
  -Dspring.profiles.active=$IDLE_PROFILE \
  $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &