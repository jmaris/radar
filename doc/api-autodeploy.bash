#!/usr/bin/env bash
gem install bundler
service unicorn stop
service nginx stop
echo "===== SHUT DOWN SERVICES ====="
cd /home/rails
rm -rf /home/rails/sonar
echo "===== DELETED OLD GIT REPO ====="
git clone https://github.com/leoncastillejos/sonar.git
echo "===== CLONED GIT REPO ====="
cp /home/rails/rails_project/config/database.yml /home/rails/sonar/src/sonar/sonar_server/config/database.yml
echo "===== COPIED DATABASE CONFIGURATION FILES ====="
sed -i -e 's/rails_project/sonar/g' /home/rails/sonar/src/sonar/sonar_server/config/database.yml
echo "===== SET UP DATABASE CONFIGURATION ====="
cd /home/rails/sonar/src/sonar/sonar_server && gem install bundler && bundle install
echo "===== SET UP RAILS GEMS ====="
. /etc/default/unicorn
RAILS_ENV=production rake db:drop
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:migrate
echo "===== MIGRATED DATABASE ====="
RAILS_ENV=production rake assets:precompile
echo "===== PRECOMPILED ASSETS ====="
chown -R rails: /home/rails/sonar
echo "===== CHANGED OWNERSHIP OF RAILS PROJECT FILES ====="
service unicorn restart
service nginx restart
echo "===== RESTARTED SERVICES ====="
