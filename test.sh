#!/bin/bash

exit_code=0

echo '*** Running fv_unified specs ***'
bundle install --jobs=3 --retry=3 | grep Installing
bundle exec rspec spec
exit_code+=$?

exit $exit_code
