function fish_greeting
end

function explain_errno -a no

    set -l errors EPERM ENOENT ESRCH EINTR EIO ENXIO E2BIG ENOEXEC EBADF \
                  ECHILD EAGAIN ENOMEM EACCES EFAULT ENOTBLK EBUSY EEXIST \
                  EXDEV ENODEV ENOTDIR EISDIR EINVAL ENFILE EMFILE ENOTTY \
                  ETXTBSY EFBIG ENOSPC ESPIPE EROFS EMLINK EPIPE EDOM \
                  ERANGE EDEADLK ENAMETOOLONG ENOLCK ENOSYS ENOTEMPTY \
                  ELOOP EWOULDBLOCK ENOMSG EIDRM ECHRNG EL2NSYNC EL3HLT \
                  EL3RST ELNRNG EUNATCH ENOCSI EL2HLT EBAD EBADR EXFULL \
                  ENOANO EBADRQC EBADSLT EDEADLOCK EBFONT ENOSTR ENODATA \
                  ETIME ENOSR ENONET ENOPKG EREMOTE ENOLINK EADV ESRMNT \
                  ECOMM EPROTO EMULTIHOP EDOTDOT EBADMSG EOVERFLOW ENOTUNIQ \
                  EBADFD EREMCHG ELIBACC ELIBBAD ELIBSCN ELIBMAX ELIBEXEC \
                  EILSEQ ERESTART ESTRPIPE EUSERS ENOTSOCK EDESTADDRREQ \
                  EMSGSIZE EPROTOTYPE ENOPROTOOPT EPROTONOSUPPORT \
                  ESOCKTNOSUPPORT EOPNOTSUPP EPFNOSUPPORT EAFNOSUPPORT \
                  EADDRINUSE EADDRNOTAVAIL ENETDOWN ENETUNREACH ENETRESET \
                  ECONNABORTED ECONNRESET ENOBUFS EISCONN ENOTCONN ESHUTDOWN \
                  ETOOMANYREFS ETIMEDOUT ECONNREFUSED EHOSTDOWN EHOSTUNREACH \
                  EALREADY EINPROGRESS ESTALE EUCLEAN ENOTNAM ENAVAIL EISNAM \
                  EREMOTEIO EDQUOT ENOMEDIUM EMEDIUMTYPE
    set -l errix $argv[1]
    echo $errors[$errix]
end

function explain_signal
    set -l signals SIGHUP SIGINT SIGQUIT SIGILL SIGTRAP SIGABRT SIGBUS \
                   SIGFPE SIGKILL SIGUSR1 SIGSEGV SIGUSR2 SIGPIPE SIGALRM \
                   SIGTERM SIGSTKFLT SIGCHLD SIGCONT SIGSTOP SIGTSTP \
                   SIGTTIN SIGTTOU SIGURG SIGXCPU SIGXFSZ SIGVTALRM \
                   SIGPROF SIGWINCH SIGIO SIGPWR SIGSYS
    set -l sigix (math $argv[1] - 128)
    echo $signals[$sigix]
end

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_char_stateseparator ''
set __fish_git_prompt_char_dirtystate '!'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
set __fish_git_prompt_char_stagedstate 'Δ'

function __fish_status_to_signal
    printf $argv[1]
    if test $argv[1] -gt 128
    end
end

function fish_prompt

    set -l last_pipestatus $pipestatus

    set -l normal (set_color normal)
    set -l grey (set_color a9a9a9)

    printf '((%s%s%s' (set_color ffb3de) (whoami) $normal
    printf '@'
    printf '%s%s:%s%s))' (set_color a9a9a9) (hostname) (prompt_pwd) $normal

    if set last_status (string match -r -- '^\d+$' $last_pipestatus[1])
        set -e argv[1]
    else
        set last_status $last_pipestatus[-1]
    end

    if test $last_status -ne "0" && test $last_status -ne "141"
        printf "s"
        set -l status_type
        set -l text_status
        set -l col
        if test $last_status -gt 128
            set status_type "sig"
            set col (set_color 8b0000)
            set text_status (explain_signal $last_status)
        else
            set status_type "err"
            set col (set_color --bold f00)
            set text_status (explain_errno $last_status)
        end
        
        printf " %s(%s%s:%s%s%s%s)%s" $grey (set_color 8b0000) $status_type $col $text_status $normal $grey $normal
    end

    printf '%s ' (fish_vcs_prompt)
end

set -x PY_MAJOR_VERSION 3.8

function py
    if test -z $V
        env python$PY_MAJOR_VERSION $argv
    else
        env python$V $argv
    end
end

function ipy
    if test -z $V
        env python$PY_MAJOR_VERSION -mIPython
    else
        env python$V -mIPython
    end
end
