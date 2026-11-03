Received: from imap6.mcr3.codethink.co.uk (imap6.mcr3.codethink.co.uk [46.37.160.117])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13769.1793719113326929035
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 07:18:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@codethink.co.uk header.s=imap6-20260915 header.b=e8Cb/BQs;
 spf=pass (domain: codethink.co.uk, ip: 46.37.160.117, mailfrom: marcel.ziswiler@codethink.co.uk)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap6-20260915; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=KlsH9qRjnwnb017kLrepes5hGa5MrrIpBRs6U/7H7EA=; b=e8Cb/BQsBDGn7z
	BPN23ZN48dwJZhXC3rDKkVexx7uR7WxYvj8meibQ1tv7qUQxaaHCgIE0/i647NDFtnMghkfkqpcXI
	iWk9UYj9oh56ZIazPyut6agLtsoOVOguSW/+jbv6IPbNELS2vmVWga8+dYd+LYY1a+46IqsYoevMp
	hBJyIwoZwDLwJY2kQ9UNfghFh8eURId+lpxxaU3c7viNr7736vRtH9L5wGuGHHsi1qwQi4lMjLkXJ
	59+Ngnle8YX6L2l8X76DrPu+H47Xt7C4+ovAonPKoY6EdsIak1gCRruNtCcUAb8Wzk2EQnEELsumH
	QpPwVYK8BAzorqWIkXGA==;
Received: from xcpe-84-227-225-151.dyn.res.sunrise.net ([84.227.225.151] helo=toolbx)
	by imap6.mcr3.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1xOGHO-001tH1-Cf; Tue, 03 Nov 2026 15:18:30 +0000
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>,
	Scott Murray <scott.murray@konsulko.com>,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Subject: [PATCH] tpm2-tools: Fix build
Date: Tue,  3 Nov 2026 16:18:24 +0100
Message-ID: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: marcel.ziswiler@codethink.co.uk
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 15:18:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5221
Content-Type: text/plain; charset="utf-8"

Fix the following build errors:

../sources/tpm2-tools-5.8/lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
../sources/tpm2-tools-5.8/lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [-Wimplicit-function-declaration]
   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
      | ^~~~~~~~~~~~~~~~~~~~~~
../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this function)
   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
      | ^~~~~~~~~~~~~~~~~~~~~~
../sources/tpm2-tools-5.8/lib/object.c:28:1: note: each undeclared identifier is reported only once for each function it appears in
../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this function)
   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
      | ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
---
 ...1-lib-object.h-include-openssl-err.h.patch | 39 +++++++++++++++++++
 .../recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb |  4 +-
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch
new file mode 100644
index 000000000000..6325c98073f4
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch
@@ -0,0 +1,39 @@
+From c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067 Mon Sep 17 00:00:00 2001
+From: Bernd Kuhls <bernd@kuhls.net>
+Date: Sat, 12 Sep 2026 13:22:13 +0200
+Subject: [PATCH] lib/object.h: include openssl/err.h
+
+Fixes build error with OpenSSL 4.1.0-alpha1:
+
+lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
+lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [-Wimplicit-function-declaration]
+   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
+
+lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this function)
+   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
+
+lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this function)
+   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
+
+Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
+Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-tools/commit/c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067]
+Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
+---
+ lib/object.h | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/lib/object.h b/lib/object.h
+index b48b55b3b06c..2c4102fcc9dd 100644
+--- a/lib/object.h
++++ b/lib/object.h
+@@ -6,6 +6,7 @@
+ #include "tpm2_util.h"
+ 
+ #include <openssl/pem.h>
++#include <openssl/err.h>
+ #include <openssl/bio.h>
+ #include <openssl/asn1.h>
+ #include <openssl/asn1t.h>
+-- 
+2.56.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
index 4edd283a739a..a87c2d0d7fa4 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
@@ -7,7 +7,9 @@ SECTION = "tpm"
 
 DEPENDS = "tpm2-tss openssl curl autoconf-archive-native"
 
-SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
+SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
+           file://0001-lib-object.h-include-openssl-err.h.patch \
+           "
 
 SRC_URI[sha256sum] = "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156a1fd92edf84bef73"
 
-- 
2.56.0

