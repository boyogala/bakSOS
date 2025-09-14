3X-UI面板搭建节点，开启CDN 加速
下载并安装SSH连接工具Finalshell（Windows、macOS、Linux 版）：

https://www.hostbuf.com/t/988.html
v2rayNG【各平台客户端下载地址】

Windows/Mac（v2rayN）：https://github.com/2dust/v2rayN/releases
Android（v2rayNG）：https://github.com/2dust/v2rayNG/releases
IOS（shadowrocket）：在外区 App Store 搜索 “Shadowrocket” 并下载
1.先更新Debian/Ubuntu系统及安装组件

apt update -y && apt install curl sudo wget git -y
2.一键安装脚本

bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
3.申请SSL证书

申请证书前，先关闭防火墙 sudo ufw disable，或者需放行端口80： ufw allow 80，这样等下证书申请才能成功。另外，还有到Cloudflare添加域名的DNS记录

4.配置节点(重点注意：搭建节点如果不能上网，记得要放行节点端口。)

①vless+grpc+reality
②vless+tcp+reality
③vless+ws+tls
④vless+tcp+tls
cloudflare标准 端口 知识

（参考资料：https://developers.cloudflare.com/fundamentals/reference/network-ports/）

80系端口(HTTP)：80，8080，8880，2052，2082，2086，2095
443系端口(HTTPS)：443，2053，2083，2087，2096，8443
Cloudflare 支持的端口，但禁用了缓存:2052,2053,2082,2083,2086,2087,2095,2096,8880,8443

优选ip工具：https://github.com/XIU2/CloudflareSpeedTest

在线优选IP：

https://stock.hostmonit.com/CloudFlareYes
https://api.uouin.com/cloudflare.html
http://ip.flares.cloud/
优选域名：

www.visa.com
www.visa.com.sg
www.visa.com.hk
www.visa.com.tw
www.visa.co.jp
www.visakorea.com
time.is
icook.hk
icook.tw
m3u8player.org/
5.启用 BBR

    在VPS的主机中，先输入x-ui,选择相应的编号，回车等待安装即可。
