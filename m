Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DBAC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 05:44:30 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15453.1716875067217159883
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 22:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S4uoSs017683
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:44:27 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90ae2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:44:26 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 22:44:26 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 22:44:25 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] tcp-smack-test/udp-smack-test: fix do_compile failure
Date: Tue, 28 May 2024 13:44:24 +0800
Message-ID: <20240528054424.4037114-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V4Mk9UZ1aqesQJgtfPAONksTy5xSG82T
X-Proofpoint-GUID: V4Mk9UZ1aqesQJgtfPAONksTy5xSG82T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=499 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280040
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 05:44:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/232

From: Changqing Li <changqing.li@windriver.com>

Include proper headers to fix following errors:
| udp_client.c:41:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
|    41 |         port = atoi(argv[1]);
| udp_client.c:52:12: error: implicit declaration of function 'fsetxattr' [-Wimplicit-function-declaration]
|    52 |         if(fsetxattr(sock, attr, label, strlen(label),0) < 0)
|       |            ^~~~~~~~~
| udp_client.c:67:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
|    67 |         close(sock);
|       |         ^~~~~
|       |         pclose
| tcp_client.c:55:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
|    55 |         port = atoi(argv[1]);
...

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 +
 recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++
 recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++
 recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c b/recipes-mac/smack/tcp-smack-test/tcp_client.c
index 6c0a474..b82b575 100644
--- a/recipes-mac/smack/tcp-smack-test/tcp_client.c
+++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c
@@ -18,6 +18,7 @@
 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 // THE SOFTWARE.
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <errno.h>
diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c b/recipes-mac/smack/tcp-smack-test/tcp_server.c
index 3c8921f..6de7ccd 100644
--- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
+++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
@@ -24,6 +24,9 @@
 #include <netinet/in.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdlib.h>
+#include <sys/xattr.h>
+
 
 int main(int argc, char* argv[])
 {
diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c b/recipes-mac/smack/udp-smack-test/udp_client.c
index 23f3e00..3d2ee31 100644
--- a/recipes-mac/smack/udp-smack-test/udp_client.c
+++ b/recipes-mac/smack/udp-smack-test/udp_client.c
@@ -19,6 +19,9 @@
 // THE SOFTWARE.
 #include <sys/socket.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/xattr.h>
 #include <netinet/in.h>
 #include <netdb.h>
 #include <string.h>
diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c b/recipes-mac/smack/udp-smack-test/udp_server.c
index 7d2fcf5..25ad1ef 100644
--- a/recipes-mac/smack/udp-smack-test/udp_server.c
+++ b/recipes-mac/smack/udp-smack-test/udp_server.c
@@ -22,6 +22,9 @@
 #include <netinet/in.h>
 #include <netdb.h>
 #include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/xattr.h>
 
 int main(int argc, char* argv[])
 {
-- 
2.25.1


