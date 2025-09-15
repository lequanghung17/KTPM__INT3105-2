
## Yêu Cầu Hệ Thống
- **Docker**: Cài đặt Docker trên máy của bạn.
- **Docker Compose**: Cài đặt Docker Compose để dễ dàng quản lý và chạy container.

## Cài Đặt
1. **Cài Đặt Docker và Docker Compose**:
   Cài đặt Docker và Docker Compose trên web

2. **Kiểm tra**:


   ```bash
   docker --version
   docker compose version
    ```
3. **Chạy Dự Án**:

    ```bash
    # Build image (khuyên dùng build sạch)
    docker compose build --no-cache

    # Chạy container nền
    docker compose up -d

    # Theo dõi log
    docker logs -f lxde-vnc

    ```
4. **Kết nối VNC**:
- **TigerVNC**: mở TigerVNC nhập
    ```bash
        127.0.0.1:5900
    ```
- **RealVNC**: mở RealVNC nhập
    ```bash
        127.0.0.1:5900
    ```

Sau đó nhập password ( mặc định docker hoặc thay đổi theo ý muốn )


