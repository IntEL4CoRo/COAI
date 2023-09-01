#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

npm create vue@latest

chown -R 1001:1002 ./moodle-demo-pages