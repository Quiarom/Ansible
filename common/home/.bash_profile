#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/quiarom/.lmstudio/bin"
# End of LM Studio CLI section


. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"

export PATH="/home/quiarom/.local/share/solana/install/active_release/bin:$PATH"
