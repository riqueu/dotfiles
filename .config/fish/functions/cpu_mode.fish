function cpu_mode
    if test (count $argv) -eq 0
        echo "Usage: cpu_mode [perf|quiet]"
        return
    end

    sudo -v # cache sudo

    if test "$argv[1]" = "perf"
        sudo wrmsr -a 0x774 0xffff
        sudo x86_energy_perf_policy performance
        echo "→ Performance mode"
    else if test "$argv[1]" = "quiet"
        sudo wrmsr -a 0x774 0x1010
        sudo x86_energy_perf_policy balance-power
        echo "→ Quiet mode"
    else
        echo "Usage: cpu_mode [perf|quiet]"
    end
end