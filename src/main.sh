#!/bin/bash
cd "$1" || exit

git log --name-only --oneline | grep -v ' ' | while read -r line ; do
    if [[ ! -e "$line" ]] ; then
        continue
    fi
    
    # 拡張子で制限したい場合
    # ex="${line##*.}"
    # if [[ $ex =~ ^js$|^ts$ ]] ; then
    #     echo "$line"
    # fi
    
    echo "$line"
    
    done | sort | uniq -c | sort -nr | while read -r line; do
    
    file_name=$(echo "$line" | cut -d ' ' -f 2)
    commit=$(echo "$line" | cut -d ' ' -f 1)
    echo "- file: $file_name"
    echo "  commit: $commit"
    echo "  authors:"
    
    if [[ -e "$file_name" ]] ; then
        git log -p "$file_name" | grep Author | while read -r author; do
            echo "$author" | cut  -d ' ' -f 2
            done | sort | uniq -c | sort -nr | while read -r author; do
            name=$(echo "$author" | cut -d ' ' -f 2)
            commit=$(echo "$author" | cut -d ' ' -f 1)
            echo "    - name: $name"
            echo "      commit: $commit"
        done
    fi
done


