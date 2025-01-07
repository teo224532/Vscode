# Sử dụng hình ảnh Ubuntu làm cơ sở
FROM ubuntu:20.04

# Cập nhật và cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    apt-transport-https \
    libx11-xcb1 \
    libxkbfile1 \
    libsecret-1-0 \
    gnome-keyring \
    libnss3 \
    && rm -rf /var/lib/apt/lists/*

# Thêm kho lưu trữ VS Code và cài đặt
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update \
    && apt-get install -y code \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f packages.microsoft.gpg

# Tạo thư mục làm việc
WORKDIR /workspace

# Thiết lập VS Code khởi chạy (cần X11 để hiển thị giao diện)
CMD ["code", "--verbose", "--user-data-dir", "/workspace/.vscode", "--no-sandbox"]
