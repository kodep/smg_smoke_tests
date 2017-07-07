#!/bin/bash
export RAILS_ENV=development
source ~/.rvm/scripts/rvm
rvm use 2.3.1
cd ../smg_backend
rvm ruby-2.3.0@smg_backend
bundle exec spring rake check_sidekiq_worker
