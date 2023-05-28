# TinyBash
Mini Shell allowing to run tiny apps, with minimal busybox

- support for /etc/shrc file
- support command redirectio (cmd > output.file)
- support environment vars (export/unset)
- prompt customisation (PS1)

## Busybox

### LittleFS commands
| Command | Description |
| ----------- | ------------ |
| apend | Append to file |
|cat | View content of file |
|cd|change current directory|
|df|disk usage|
|format|format filesystem|
|head|dump first lines of a file|
|hexdump|dump file in hexa|
|ls|list files|
|mkdir|create directory|
|mv|move file|
|nl|number lines of a file|
|rm|remove a file|
|pwd|show current directory|
|rmdir|remove an empty directory|
|tail|dump last lines of a file|
|touch|create an empty file|
|wc|Count lines words chars|

### Terminal commands
| Command | Description |
| ----------- | ------------ |
|ansi|ansi escape tests|
|clear|clear the screen|
|echo|echo to terminal|
|termcap|view terminal caps|

### TinyBash commands
| Command | Description |
| ----------- | ------------ |
|export|export var=value|
|unset|remove env var|
|path|add folders to search commands for|


### Network commands
ping
wget (not activated by default)

### Miscelaneous
| Command | Description |
| ----------- | ------------ |
|free|show mem stats|
|help|show list of commands, minimal help|
|int|evaluate an int|
|lorem|create a lorem ipsum text|
|print_at|print a text at a given position|
|vim|mini vi for tinybash !!!|


