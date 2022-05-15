function run_test {
    clear
    date
    lua run_test.lua
}

paths='-r .'
paths=$paths' -r ../game/scripts'
paths=$paths' -r ../submodules'

run_test
while true; do
    inotifywait $paths
    sleep 1
    run_test
done
