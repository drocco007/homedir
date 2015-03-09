# This theme for gitprompt.sh is optimized for the "Solarized Dark" and "Solarized Light" color schemes
# without the indicator of the last command state
# tweaked for Ubuntu terminal fonts

override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Solarized NoExitState"
  GIT_PROMPT_CHANGED="${BoldYellow}✚ "
  GIT_PROMPT_STAGED="${Yellow}●"
  GIT_PROMPT_UNTRACKED="${Cyan}…"
  GIT_PROMPT_STASHED="${BoldMagenta}⚑ "
  GIT_PROMPT_CLEAN="${Green}✔"
  GIT_PROMPT_COMMAND_OK="${Green}✔"
  GIT_PROMPT_COMMAND_FAIL="${Red}✘"
  # GIT_PROMPT_START_USER="${Yellow}${PathShort}${ResetColor}"
  GIT_PROMPT_START_USER="${DimCyan}${PathShort}${ResetColor}"
  GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
  GIT_PROMPT_END_USER="${ResetColor}$ "
  GIT_PROMPT_END_ROOT="${BoldRed}# "
  GIT_PROMPT_VIRTUALENV="(${DimYellow}_VIRTUALENV_${ResetColor}) "
}

reload_git_prompt_colors "Solarized NoExitState"
