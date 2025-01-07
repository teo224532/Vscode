# Sử dụng image cơ bản chính thức của JupyterLab
FROM jupyter/base-notebook:latest

# Đặt người dùng về root để cài đặt các gói bổ sung
USER root

# Cài đặt JupyterLab và các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo && \
    pip install --upgrade pip && \
    pip install jupyterlab && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo một người dùng không root để sử dụng nếu cần
ARG NB_USER=jupyter
ARG NB_UID=1000
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/notebook && \
    chmod 0440 /etc/sudoers.d/notebook

# Chuyển về thư mục làm việc
WORKDIR /home/$NB_USER

# Cấu hình mặc định để JupyterLab chạy trên mọi giao diện mạng
ENV JUPYTER_TOKEN=''
ENV JUPYTER_ENABLE_LAB=yes

# Mở cổng 8888
EXPOSE 8888

# Chạy JupyterLab với quyền root
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
