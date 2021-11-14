function fish_right_prompt
  set -l cwd
    set -l cwd_color (set_color yellow)
    set -l symbol_color (set_color blue)

    if git_is_repo
        set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
        set parent_root_folder (dirname $root_folder)
        set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    else
        set cwd (prompt_pwd)
    end

    echo -n -s $cwd_color "$cwd"
    
    set_color normal

    set -l S (math $CMD_DURATION/1000)
    set -l M (math $S/60)

    echo -n -s " "
    if test $M -gt 1
        echo -n -s $dim_normal $M m
    else if test $S -gt 1
        echo -n -s $S s  " 死"
    else
        echo -n -s $CMD_DURATION ms
    end
end