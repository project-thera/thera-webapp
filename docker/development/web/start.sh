bundle install
rails db:create
rails db:migrate

## Sometimes PID file can exist after restart. Cleaning.
if [[ -f "$PIDFILE" ]]; then
  pid=$(cat "$PIDFILE")
  if [[ -n "$(ps -p $pid -o pid=)" ]]; then
    echo "Another instance is running: $pid. Exiting..."
    exit 1
  else
    echo "Removing uncleaned pid file: $PIDFILE"
    rm -f "$PIDFILE"
  fi
fi

exec bundle exec rails s -p 3000 -b '0.0.0.0'