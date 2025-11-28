#!/bin/bash
set -euo pipefail

echo "🌐 Ubuntu 22 DNS ayarlama başlatılıyor..."


PRIMARY_DNS="195.175.39.49"
SECONDARY_DNS="8.8.8.8"
FALLBACK_DNS="1.1.1.1"


sudo bash -c "cat > /etc/systemd/resolved.conf" <<EOF
[Resolve]
DNS=${PRIMARY_DNS} ${SECONDARY_DNS}
FallbackDNS=${FALLBACK_DNS}
DNSStubListener=yes
EOF

echo " /etc/systemd/resolved.conf güncellendi."


sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
echo " /etc/resolv.conf bağlantısı düzeltildi."


sudo systemctl restart systemd-resolved
echo " systemd-resolved yeniden başlatıldı."


echo " Yeni DNS sunucuları:"
systemd-resolve --status | grep 'DNS Servers' -A2 || true

echo " DNS ayarları başarıyla uygulandı!"
