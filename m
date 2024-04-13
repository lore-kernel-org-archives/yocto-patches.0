Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.11739.1713014739338994811
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Apr 2024 06:25:39 -0700
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43DDN3TE000822
	for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Apr 2024 06:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=FL6QPmkYFwg7Fx5/ri
	smDWx/OvNWoLMt6OkXUOXmqIo=; b=OOL9HWdLE/eEAbABc2kIGDW+fkQZPZOE5r
	O4tlKvkf/0OvRnp7HKidHhxvT22rRZusJmk3LFWBTN/Uz2DACeOMYdBFCGxXSy5T
	WO3FwXH/UkBr/2+WKLA5KaYZwIw0HuUr0Zq0RTFMdR/+pdU3hTUAskn1jkF+MB4X
	PqVEQsSANIE1rNyMILJie/2xOwmwIk8DV4rxwWRv49WcYDYnByZuRtPQsXEUzhgO
	KBmHTivu0PX9rHOxoKcjR0xUkAC+Q5dM6BYw6+33WcTyF3Ic+bIU7IKiYIi6e0fu
	wPcd12ZlM1DJ3S3GclN78dWqA+sfxIoqC6uXSdgfE/YUoBMyeJIA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xfsjgr1bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Apr 2024 06:25:38 -0700 (PDT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH] ibmswtpm2: upgrade 164-2020-192.1 -> 183-2024-03-27
Date: Sat, 13 Apr 2024 21:25:24 +0800
Message-Id: <20240413132524.1910943-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Remove '-DALG_CAMELLIA=ALG_NO' from CFLAGS to fix compile error:
| TpmProfile_Common.h:109: error: "ALG_CAMELLIA" redefined [-Werror]
|   109 | #define ALG_CAMELLIA                ALG_YES
|       |

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...swtpm2_164-2020-192.1.bb => ibmswtpm2_183-2024-03-27.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename meta-tpm/recipes-tpm2/ibmswtpm2/{ibmswtpm2_164-2020-192.1.bb => ibmswtpm2_183-2024-03-27.bb} (86%)

diff --git a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
similarity index 86%
rename from meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb
rename to meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
index 7060a64..7ed9569 100644
--- a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb
+++ b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
@@ -19,13 +19,13 @@ DEPENDS = "openssl"
 SRC_URI = "git://git.code.sf.net/p/ibmswtpm2/tpm2;protocol=https;branch=master \
            file://tune-makefile.patch \
            "
-SRCREV = "5452af422edeff70fcae8ea99dd28a0922051d7b"
+SRCREV = "c37c74438429e1d5fe465232e7bf894b239a2cd4"
 
-UPSTREAM_CHECK_URI = "https://git.code.sf.net/p/ibmswtpm2/tpm2"
+UPSTREAM_CHECK_GITTAGREGEX = "rev(?P<pver>\d+(\-\d+)+)"
 
 S = "${WORKDIR}/git/src"
 
-CFLAGS += "-Wno-error=maybe-uninitialized -DALG_CAMELLIA=ALG_NO"
+CFLAGS += "-Wno-error=maybe-uninitialized"
 
 do_compile () {
    make CC='${CC}'
-- 
2.25.1

