# Enable colored prompt
force_color_prompt=yes

# To fix Vivado GUI problems via X11 forwarding
export LC_ALL=en_US.UTF-8

# Aliases
alias update='sudo apt-get update && sudo apt-get -y upgrade'
alias ls='ls -F --color'
alias ll='ls -lF --color'
alias la='ls -alF --color'

# Brightness shortcuts
alias x0='xbacklight -set 0'
alias x100='xbacklight -set 100'
alias xinc='xbacklight -inc 20'
alias xdec='xbacklight -dec 20'

# GNAT and ghdl
export PATH="$PATH:/opt/GNAT/2019/bin"
export PATH="$PATH:/usr/local/bin"

# Sigasi
export PATH="$PATH:/opt/sigasi"

# Xilinx
alias vivado='/opt/xilinx/Vivado/2018.3/bin/vivado &'
alias hls='/opt/xilinx/Vivado/2018.3/bin/vivado_hls'
run_hls () {
    /opt/xilinx/Vivado/2018.3/bin/vivado_hls -f $1
}
alias hls_cmd='/opt/xilinx/Vivado/2018.3/bin/vivado_hls -i'

# Intel/Altera
program_fpga () {
    quartus_pgm -m jtag -o "p;$1@2"
}

export QSYS_ROOTDIR="/opt/intelFPGA/18.1/quartus/sopc_builder/bin"
export PATH="$PATH:/opt/intelFPGA/18.1/modelsim_ase/bin" 
export PATH="$PATH:/opt/intelFPGA/18.1/quartus/bin" 

# MathWorks
alias matlab18='/usr/local/MATLAB/R2018a/bin/matlab -softwareopengl &'
alias matlab19a='/usr/local/MATLAB/R2019a/bin/matlab -softwareopengl &'
alias matlab19b='/usr/local/MATLAB/R2019b/bin/matlab -softwareopengl &'

# Other alias
alias urban='/usr/games/UrbanTerror43/Quake3-UrT.x86_64'

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1 && cd $(echo $1 | sed 's/.tar.bz2//')    ;;
           *.tar.gz)    tar xvzf $1 && cd $(echo $1 | sed 's/.tar.gz//')    ;;
           *.bz2)       bunzip2 $1 && cd $(echo $1 | sed 's/.bz2//')    ;;
           *.rar)       unrar x $1 && cd $(echo $1 | sed 's/.rar//')    ;;
           *.gz)        gunzip $1 && cd $(echo $1 | sed 's/.gz//')    ;;
           *.tar)       tar xvf $1 && cd $(echo $1 | sed 's/.tar//')    ;;
           *.tbz2)      tar xvjf $1 && cd $(echo $1 | sed 's/.tbz2//')    ;;
           *.tgz)       tar xvzf $1 && cd $(echo $1 | sed 's/.tgz//')    ;;
           *.zip)       unzip $1 && cd $(echo $1 | sed 's/.zip//')    ;;
           *.Z)         uncompress $1 && cd $(echo $1 | sed 's/.Z//')    ;;
           *.7z)        7z x $1 && cd $(echo $1 | sed 's/.7z//')    ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Prompt code copied from https://github.com/jcgoble3/gitstuff/blob/master/gitprompt.sh
# Prompt: '<blue path>[Colored Git info]$ '
PS1='\h $(git_prompt) \[\033[01;34m\]\w\[\033[00m\]\$ '

git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # ! unstaged changes are present, ? untracked files are present
    # S changes have been stashed, P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # - White if everything is clean, green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;34m' # bold blue
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    local branch=$(git_branch)
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02"  # last bit resets color
    fi
}


