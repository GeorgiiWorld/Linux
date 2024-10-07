#!/bin/bash

start_time=$(date +%s.%N)
dir_path=$1
if [[ $# -ne 1 ]] || [[ "${dir_path: -1}" != "/" ]]; then
  echo "Usage: $0 directory_path/"
  exit 1
fi

if [[ ! -d $dir_path ]]; then
  echo "Directory does not exist: $dir_path"
  exit 1
fi

total_folders=$(find $dir_path -type d | wc -l)
top_folders=$(du -sh $dir_path* | sort -rh | head -n 5 | awk '{printf "%d - %s, %s\n", NR, $2, $1}')
total_files=$(find $dir_path -type f | wc -l)
conf_files=$(find $dir_path -type f -name "*.conf" | wc -l)
text_files=$(find $dir_path -type f -name "*.txt" | wc -l)
exe_files=$(find $dir_path -type f -executable | wc -l)
log_files=$(find $dir_path -type f -name "*.log" | wc -l)
archive_files=$(find $dir_path -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.bz2" \) | wc -l)
symbolic_links=$(find $dir_path -type l | wc -l)

top_files=$(find $dir_path -type f -printf '%s %p\n' | sort -nr | head -n 10 | awk -F '.' '{print $0 " " $NF}' | awk '{printf "%d - %s, %skb, %s\n", NR, $2, $1, $3}')
top_executables=$(find $dir_path -type f -executable -exec -printf '%s %p\n' | sort -nr | head -n 10 | awk '{printf "%d - %s, %skb\n", NR, $2, $1}')
function print_top_exe() {
  exec_list=$(find $1 -type f -executable -exec du -h -d 1 {} + | sort -rh | head -10 | awk 'BEGIN {i=1} { printf "%d %s %s\n", i, $2, $1; i++ }')
  printf "%s\n" "$exec_list" |
  while IFS= read -r line; do
    echo "$(echo $line | awk '{printf "%d - %s, %s, ", $1, $2, $3}') $(md5sum $(echo $line | awk '{print $2}') | awk '{print $1}')"
  done
}

echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders"
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files= $text_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symbolic_links"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
  print_top_exe

end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)
if [[ $execution_time =~ ^[.] ]]; then
  execution_time=0$execution_time
fi
echo "Script execution time (in seconds) = $execution_time"
