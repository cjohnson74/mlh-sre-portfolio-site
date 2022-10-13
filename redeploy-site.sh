#!/bin/bash

tmux kill-server

cd ~/mlh-sre-portfolio-site

git fetch && git reset origin/main --hard

source python3-virtualenv/bin/activate

pip install -r requirements.txt

tmux new-session -d -s project_session 'flask run --host=0.0.0.0'
