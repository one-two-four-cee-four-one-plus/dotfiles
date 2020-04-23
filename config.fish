function fish_greeting
end

function explain_errno -a no
    if test "$no" -eq "1"; printf "EPERM"; end
    if test "$no" -eq "2"; printf "ENOENT"; end
    if test "$no" -eq "3"; printf "ESRCH"; end
    if test "$no" -eq "4"; printf "EINTR"; end
    if test "$no" -eq "5"; printf "EIO"; end
    if test "$no" -eq "6"; printf "ENXIO"; end
    if test "$no" -eq "7"; printf "E2BIG"; end
    if test "$no" -eq "8"; printf "ENOEXEC"; end
    if test "$no" -eq "9"; printf "EBADF"; end
    if test "$no" -eq "10"; printf "ECHILD"; end
    if test "$no" -eq "11"; printf "EAGAIN"; end
    if test "$no" -eq "12"; printf "ENOMEM"; end
    if test "$no" -eq "13"; printf "EACCES"; end
    if test "$no" -eq "14"; printf "EFAULT"; end
    if test "$no" -eq "15"; printf "ENOTBLK"; end
    if test "$no" -eq "16"; printf "EBUSY"; end
    if test "$no" -eq "17"; printf "EEXIST"; end
    if test "$no" -eq "18"; printf "EXDEV"; end
    if test "$no" -eq "19"; printf "ENODEV"; end
    if test "$no" -eq "20"; printf "ENOTDIR"; end
    if test "$no" -eq "21"; printf "EISDIR"; end
    if test "$no" -eq "22"; printf "EINVAL"; end
    if test "$no" -eq "23"; printf "ENFILE"; end
    if test "$no" -eq "24"; printf "EMFILE"; end
    if test "$no" -eq "25"; printf "ENOTTY"; end
    if test "$no" -eq "26"; printf "ETXTBSY"; end
    if test "$no" -eq "27"; printf "EFBIG"; end
    if test "$no" -eq "28"; printf "ENOSPC"; end
    if test "$no" -eq "29"; printf "ESPIPE"; end
    if test "$no" -eq "30"; printf "EROFS"; end
    if test "$no" -eq "31"; printf "EMLINK"; end
    if test "$no" -eq "32"; printf "EPIPE"; end
    if test "$no" -eq "33"; printf "EDOM"; end
    if test "$no" -eq "34"; printf "ERANGE"; end
    if test "$no" -eq "35"; printf "EDEADLK"; end
    if test "$no" -eq "36"; printf "ENAMETOOLONG"; end
    if test "$no" -eq "37"; printf "ENOLCK"; end
    if test "$no" -eq "38"; printf "ENOSYS"; end
    if test "$no" -eq "39"; printf "ENOTEMPTY"; end
    if test "$no" -eq "40"; printf "ELOOP"; end
    if test "$no" -eq "42"; printf "ENOMSG"; end
    if test "$no" -eq "43"; printf "EIDRM"; end
    if test "$no" -eq "44"; printf "ECHRNG"; end
    if test "$no" -eq "45"; printf "EL2NSYNC"; end
    if test "$no" -eq "46"; printf "EL3HLT"; end
    if test "$no" -eq "47"; printf "EL3RST"; end
    if test "$no" -eq "48"; printf "ELNRNG"; end
    if test "$no" -eq "49"; printf "EUNATCH"; end
    if test "$no" -eq "50"; printf "ENOCSI"; end
    if test "$no" -eq "51"; printf "EL2HLT"; end
    if test "$no" -eq "52"; printf "EBADE"; end
    if test "$no" -eq "53"; printf "EBADR"; end
    if test "$no" -eq "54"; printf "EXFULL"; end
    if test "$no" -eq "55"; printf "ENOANO"; end
    if test "$no" -eq "56"; printf "EBADRQC"; end
    if test "$no" -eq "57"; printf "EBADSLT"; end
    if test "$no" -eq "59"; printf "EBFONT"; end
    if test "$no" -eq "60"; printf "ENOSTR"; end
    if test "$no" -eq "61"; printf "ENODATA"; end
    if test "$no" -eq "62"; printf "ETIME"; end
    if test "$no" -eq "63"; printf "ENOSR"; end
    if test "$no" -eq "64"; printf "ENONET"; end
    if test "$no" -eq "65"; printf "ENOPKG"; end
    if test "$no" -eq "66"; printf "EREMOTE"; end
    if test "$no" -eq "67"; printf "ENOLINK"; end
    if test "$no" -eq "68"; printf "EADV"; end
    if test "$no" -eq "69"; printf "ESRMNT"; end
    if test "$no" -eq "70"; printf "ECOMM"; end
    if test "$no" -eq "71"; printf "EPROTO"; end
    if test "$no" -eq "72"; printf "EMULTIHOP"; end
    if test "$no" -eq "73"; printf "EDOTDOT"; end
    if test "$no" -eq "74"; printf "EBADMSG"; end
    if test "$no" -eq "75"; printf "EOVERFLOW"; end
    if test "$no" -eq "76"; printf "ENOTUNIQ"; end
    if test "$no" -eq "77"; printf "EBADFD"; end
    if test "$no" -eq "78"; printf "EREMCHG"; end
    if test "$no" -eq "79"; printf "ELIBACC"; end
    if test "$no" -eq "80"; printf "ELIBBAD"; end
    if test "$no" -eq "81"; printf "ELIBSCN"; end
    if test "$no" -eq "82"; printf "ELIBMAX"; end
    if test "$no" -eq "83"; printf "ELIBEXEC"; end
    if test "$no" -eq "84"; printf "EILSEQ"; end
    if test "$no" -eq "85"; printf "ERESTART"; end
    if test "$no" -eq "86"; printf "ESTRPIPE"; end
    if test "$no" -eq "87"; printf "EUSERS"; end
    if test "$no" -eq "88"; printf "ENOTSOCK"; end
    if test "$no" -eq "89"; printf "EDESTADDRREQ"; end
    if test "$no" -eq "90"; printf "EMSGSIZE"; end
    if test "$no" -eq "91"; printf "EPROTOTYPE"; end
    if test "$no" -eq "92"; printf "ENOPROTOOPT"; end
    if test "$no" -eq "93"; printf "EPROTONOSUPPORT"; end
    if test "$no" -eq "94"; printf "ESOCKTNOSUPPORT"; end
    if test "$no" -eq "95"; printf "EOPNOTSUPP"; end
    if test "$no" -eq "96"; printf "EPFNOSUPPORT"; end
    if test "$no" -eq "97"; printf "EAFNOSUPPORT"; end
    if test "$no" -eq "98"; printf "EADDRINUSE"; end
    if test "$no" -eq "99"; printf "EADDRNOTAVAIL"; end
    if test "$no" -eq "100"; printf "ENETDOWN"; end
    if test "$no" -eq "101"; printf "ENETUNREACH"; end
    if test "$no" -eq "102"; printf "ENETRESET"; end
    if test "$no" -eq "103"; printf "ECONNABORTED"; end
    if test "$no" -eq "104"; printf "ECONNRESET"; end
    if test "$no" -eq "105"; printf "ENOBUFS"; end
    if test "$no" -eq "106"; printf "EISCONN"; end
    if test "$no" -eq "107"; printf "ENOTCONN"; end
    if test "$no" -eq "108"; printf "ESHUTDOWN"; end
    if test "$no" -eq "109"; printf "ETOOMANYREFS"; end
    if test "$no" -eq "110"; printf "ETIMEDOUT"; end
    if test "$no" -eq "111"; printf "ECONNREFUSED"; end
    if test "$no" -eq "112"; printf "EHOSTDOWN"; end
    if test "$no" -eq "113"; printf "EHOSTUNREACH"; end
    if test "$no" -eq "114"; printf "EALREADY"; end
    if test "$no" -eq "115"; printf "EINPROGRESS"; end
    if test "$no" -eq "116"; printf "ESTALE"; end
    if test "$no" -eq "117"; printf "EUCLEAN"; end
    if test "$no" -eq "118"; printf "ENOTNAM"; end
    if test "$no" -eq "119"; printf "ENAVAIL"; end
    if test "$no" -eq "120"; printf "EISNAM"; end
    if test "$no" -eq "121"; printf "EREMOTEIO"; end
    if test "$no" -eq "122"; printf "EDQUOT"; end
    if test "$no" -eq "123"; printf "ENOMEDIUM"; end
    if test "$no" -eq "124"; printf "EMEDIUMTYPE"; end
    if test "$no" -eq "125"; printf "?"; end
    if test "$no" -eq "126"; printf "CANNOT EXECUTE"; end
    if test "$no" -eq "127"; printf "CMD 404"; end
    if test "$no" -eq "128"; printf "INVALID EXIT() ARG"; end
    if test "$no" -eq "129"; printf "SIGHUP"; end
    if test "$no" -eq "130"; printf "SIGINT"; end
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

function fish_prompt
    set -l last_status $status
    
    printf '((%s%s%s' (set_color ffb3de) (whoami) (set_color normal)
    printf '@'
    printf '%s%s:%s%s))' (set_color a9a9a9) (hostname) (prompt_pwd) (set_color normal)

    if test $last_status -ne "0"
        printf " %s(%serr:%s%s%s%s)%s" (set_color a9a9a9) (set_color 8b0000) (set_color ff0000) (explain_errno $last_status) (set_color 8b0000) (set_color a9a9a9) (set_color normal)
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
