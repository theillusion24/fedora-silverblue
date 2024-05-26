# Add additional boot parameters for hardening (requires reboot)
set-kargs-hardening:
    #!/usr/bin/pkexec /usr/bin/bash
    rpm-ostree kargs \
          --append-if-missing="init_on_alloc=1" \
          --append-if-missing="init_on_free=1" \
          --append-if-missing="slab_nomerge" \
          --append-if-missing="page_alloc.shuffle=1" \
          --append-if-missing="debugfs=off" \
          --append-if-missing="random.trust_cpu=off" \
          --append-if-missing="random.trust_bootloader=off" \
          --append-if-missing="iommu=force" \
          --append-if-missing="intel_iommu=on" \
          --append-if-missing="iommu.passthrough=0" \
          --append-if-missing="iommu.strict=1" \
          --append-if-missing="efi=disable_early_pci_dma" \
          --append-if-missing="randomize_kstack_offset=on" \
          --append-if-missing="vsyscall=none" \
          --append-if-missing="lockdown=confidentiality" \
          --append-if-missing="pti=on" \
          --append-if-missing="module.sig_enforce=1" \
    echo "Hardening kargs set."

# Remove all hardening boot parameters (requires reboot)
#!/usr/bin/pkexec /usr/bin/bash
remove-kargs-hardening:
    rpm-ostree kargs \
          --delete-if-present="init_on_alloc=1" \
          --delete-if-present="init_on_free=1" \
          --delete-if-present="slab_nomerge" \
          --delete-if-present="page_alloc.shuffle=1" \
          --delete-if-present="debugfs=off" \
          --delete-if-present="random.trust_cpu=off" \
          --delete-if-present="random.trust_bootloader=off" \
          --delete-if-present="iommu=force" \
          --delete-if-present="intel_iommu=on" \
          --delete-if-present="iommu.passthrough=0" \
          --delete-if-present="iommu.strict=1" \
          --delete-if-present="efi=disable_early_pci_dma" \
          --delete-if-present="randomize_kstack_offset=on" \
          --delete-if-present="vsyscall=none" \
          --delete-if-present="lockdown=confidentiality" \
          --delete-if-present="pti=on" \
          --delete-if-present="module.sig_enforce=1" \

# Enable discard/trim support on encrypted drive
#!/usr/bin/pkexec /usr/bin/bash
set-crypt-optimize:
    cryptsetup --allow-discards --perf-no_read_workqueue --perf-no_write_workqueue --persistent refresh /dev/mapper/luks*