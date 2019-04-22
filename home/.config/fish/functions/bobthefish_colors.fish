
function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'
  set red "#E06C75"
  set magenta "#C678DD"
  set green "#98C379"
  set bright_black "#5C6370"
  set white "#9CA8BA"
  set blue "#61AFEF"
  set yellow "#D19A66"
  set selection "#363b46"
  set background "#1E2127"

  # Optionally include a base color scheme
  __bobthefish_colors default

  # Then override everything you want!
  # Note that these must be defined with `set -x`
  set -x color_initial_segment_exit     white red --bold
  set -x color_initial_segment_su       white green --bold
  set -x color_initial_segment_jobs     white blue --bold

  set -x color_path                     $selection $white
  set -x color_path_basename            $selection $white --bold
  set -x color_path_nowrite             $red $white
  set -x color_path_nowrite_basename    $red $white --bold

  set -x color_repo                     $green $background
  set -x color_repo_work_tree           black black --bold
  set -x color_repo_dirty               $red $background
  set -x color_repo_staged              $yellow $background

  set -x color_vi_mode_default          brblue black --bold
  set -x color_vi_mode_insert           brgreen black --bold
  set -x color_vi_mode_visual           bryellow black --bold

  set -x color_vagrant                  brcyan black
  set -x color_k8s                      magenta white --bold
  set -x color_username                 white black --bold
  set -x color_hostname                 white black
  set -x color_rvm                      brmagenta black --bold
  set -x color_virtualfish              brblue black --bold
  set -x color_virtualgo                brblue black --bold
  set -x color_desk                     brblue black --bold
end