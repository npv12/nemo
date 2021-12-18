function fish_prompt
  set -l last_command_status $status

  # All the symbols used here

  # Arrow symbol
  set -l symbol   "" 
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"


  # All the colors used here

  set -l normal_color (set_color normal)
  set -l branch_color (set_color yellow)
  set -l meta_color (set_color red)
  set -l symbol_color (set_color blue -o)
  set -l error_color (set_color red -o)
  set -l success_color (set_color green -o)
  set -l directory_color  (set_color yellow)
  set -l repository_color (set_color green)


  # Sets the symbol green if last command was success

  if test $last_command_status -eq 0
    echo -n -s $success_color $symbol $normal_color
  else
    echo -n -s $error_color $symbol $normal_color
  end


  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
    end

    echo -n -s " on " $repository_color (git_branch_name) $normal_color " "

    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
  end

  echo -n -s " "

  function sideload --description "Sideload a file effortlessly using adb"
    adb reboot sideload-auto-reboot && adb wait-for-device-sideload && adb sideload a
  end
  
end