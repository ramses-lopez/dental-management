#tmux new-session -d -s pin
#tmux new-window -t pin:0 -n 'heroku-lab'
#tmux send-keys -t pin:0 'heroku maintenance:on -a dento-spa && heroku pg:reset DATABASE --confirm dento-spa -a dento-spa && heroku run rake db:migrate -a dento-spa && heroku run rake db:seed -a dento-spa && heroku run rake db:populate -a dento-spa && heroku maintenance:off -a dento-spa' C-m
#tmux new-window -t pin:1 -n 'heroku-test'
#tmux send-keys -t pin:1 'heroku maintenance:on -a pin-banesco-test && heroku pg:reset DATABASE --confirm pin-banesco-test -a pin-banesco-test && heroku run rake db:migrate -a pin-banesco-test && heroku run rake db:seed -a pin-banesco-test && heroku run rake db:populate -a pin-banesco-test && heroku maintenance:off -a pin-banesco-test' C-m
#tmux new-window -t pin:2 -n 'heroku-final'
#tmux send-keys -t pin:2 'heroku maintenance:on -a pin && heroku pg:reset DATABASE --confirm pin -a pin && heroku run rake db:migrate -a pin && heroku run rake db:seed -a pin && heroku run rake db:populate -a pin && heroku maintenance:off -a pin' C-m
#tmux select-window -t pin:0
#tmux -2 attach-session -t pin

heroku maintenance:on -a dento-spa && heroku pg:reset DATABASE --confirm dento-spa -a dento-spa && heroku run rake db:migrate -a dento-spa && heroku run rake db:seed -a dento-spa && heroku run rake db:populate -a dento-spa && heroku maintenance:off -a dento-spa