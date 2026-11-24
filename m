Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10903.1795491236714800874
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 19:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=dIs8WOm4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: nirameka@qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kBup196998;
	Tue, 24 Nov 2026 03:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jj+oC7PHlFq
	/mfwTzJudJ8N+eB9ZV4Gl9fjH0jJTEJ0=; b=dIs8WOm4YrLguv2cShTcUjxSD+f
	Knc6SOG2DMcNiVnAh1fcdmEdOeYtj/C0ydKUpYoms1Reaw7RRNrQX0+n3iB9yF+R
	eemM098eGF7f+jykrGE7rTqUZAjl6Rr0FtYBSGccrVrQ1mCH3DWkAPcM5J0aS0+R
	R9l5fHzY5+MzpFCp2FeRI6oeKmtsJHg9NP4UMR1WQQRvivV0EmyiQ7n0HmhTnKNY
	FzcvDmx+vGMzML9bu/mFbTDeB4XjZgVui9BK1bfQXR/G4KxxZOrz2Key/JRFTJwI
	aZUAstkrg7IFnybcesxopSXqhlzO4yFhTKiGrSq6/DHac977j6D1o3TWJKQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr9gwv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO3XsuA3874712;
	Tue, 24 Nov 2026 03:33:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-nirameka-lv.qualcomm.com [10.81.87.106])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AO3XrGO3874702
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4849491)
	id 7187322202; Mon, 23 Nov 2026 19:33:53 -0800 (PST)
From: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com,
        Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
Subject: [meta-security][PATCH 2/2] swtpm: backport sysusers and tmpfiles support
Date: Mon, 23 Nov 2026 19:33:42 -0800
Message-ID: <20261124033342.3126460-3-nirameka@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124033342.3126460-1-nirameka@qti.qualcomm.com>
References: <20261124033342.3126460-1-nirameka@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfX3mAQ+I8NoQG5
 fI2cuXJtv2OQcaBUL9LRkksqwJ1LA4qY4TuBIbrD9NQafSo4fGUvjTWlOzrPp9IObH+tEf/4v0Z
 0MbIpjh7YeI2f2uRgKhPc0FsIbk/ka4=
X-Proofpoint-ORIG-GUID: NIpNASpIHA6WARBewmCdeknvprAlEGPo
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b0505a2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=y9ODRZLtcAC_H99eu_MA:9 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfXzvPl7nMOxuSf
 H2b9ymG9k5hTwQP303VK4pD+mu1inTjYgjwkKPNwSKXtcy8T6OnQd5OTRYm/rl/i3HYBD3dMaV+
 BOSgMuutjBx5bXcZAx8y4m9/8u4WTcFMZJxGOV7Y4sAbBTE0ubvNw4EY4GyfyGS2+d2xpPkeI4y
 8TxmplDjTG0IujSWwgCgKcJn1ko2lnmEVF5W49MBAQYO0GU/fwUHvhB8bFF086y5YFvNuf1XjKK
 Yrkx/fRmeEN54N/RzyaAUNfs8q0Aaug/OOMcPiUvTFQhCDS7t1NxdvueuEbK/yhnA+egS2CC6MG
 z18mWV+cw/vOi9Oabc6NlfMWO/UDUcfWReiNC8HT+bb9/RkINsT4Lbwv6Mr5aaRyWaGNaLm1xur
 ont8dOYuPwZ0Zwh7YRM0rgE4+BKoDi5/cH+cQ/L7HfZhsCQjvdyu7PzXXv0qvirsy1cekEJIWW2
 3Gx39d6ndZXpZ6g7FvA==
X-Proofpoint-GUID: NIpNASpIHA6WARBewmCdeknvprAlEGPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240013
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 03:34:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5499
Content-Type: text/plain; charset="utf-8"

Backport the upstream sysusers.d and tmpfiles.d integration to
provision the tss user and /var/lib/swtpm-localca declaratively.

Also backport the follow-up change that aligns the tss sysusers
definition with tpm2-tss to avoid conflicting definitions.

Package the generated sysusers.d and tmpfiles.d configuration files.

Signed-off-by: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
---
 ...ll-sysusers.d-and-tmpfiles.d-configs.patch | 86 +++++++++++++++++++
 ...2-swtpm-sync-sysuser.d-with-tpm2-tss.patch | 29 +++++++
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb    |  9 +-
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch b/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
new file mode 100644
index 0000000..3fc414d
--- /dev/null
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
@@ -0,0 +1,86 @@
+From d318d40469474eb8f3ccc4a6e9fe0ba100814e20 Mon Sep 17 00:00:00 2001
+From: Luca Boccassi <luca.boccassi@gmail.com>
+Date: Mon, 22 Sep 2025 17:56:24 +0100
+Subject: [PATCH] swtpm: install sysusers.d and tmpfiles.d configs
+
+These configuration files will create the required user, group and
+data directory on first boot/factory reset/package installation,
+without requiring manual scripts or actions. This is very important
+for image-based OSes, but it is useful in other cases to, to allow
+using declarative configuration instead of scripts.
+
+RPM now has built-in support for sysusers.d too.
+
+https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
+https://www.freedesktop.org/software/systemd/man/latest/sysusers.d.html
+
+Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
+Upstream-Status: Backport [https://github.com/stefanberger/swtpm/commit/d318d40469474eb8f3ccc4a6e9fe0ba100814e20]
+---
+ .gitignore                 |  2 ++
+ configure.ac               |  2 ++
+ src/Makefile.am            | 10 ++++++++++
+ src/swtpm-sysusers.conf.in |  1 +
+ src/swtpm-tmpfiles.conf.in |  1 +
+ 5 files changed, 16 insertions(+)
+ create mode 100644 src/swtpm-sysusers.conf.in
+ create mode 100644 src/swtpm-tmpfiles.conf.in
+
+diff --git a/.gitignore b/.gitignore
+index 579d0be..012ef88 100644
+--- a/.gitignore
++++ b/.gitignore
+@@ -63,6 +63,8 @@ Makefile
+ /src/swtpm_ioctl/swtpm_ioctl
+ /src/swtpm_localca/swtpm_localca
+ /src/swtpm_setup/swtpm_setup
++/src/swtpm-sysusers.conf
++/src/swtpm-tmpfiles.conf
+ /src/utils/swtpm_conf.h
+ /test-driver
+ tests/*.log
+diff --git a/configure.ac b/configure.ac
+index afcd18a..4eab9f4 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -502,6 +502,8 @@ AC_CONFIG_FILES([Makefile                   \
+ 		src/swtpm_ioctl/Makefile    \
+ 		src/swtpm_localca/Makefile  \
+ 		src/swtpm_setup/Makefile    \
++		src/swtpm-sysusers.conf     \
++		src/swtpm-tmpfiles.conf     \
+ 		src/utils/Makefile          \
+ 		src/utils/swtpm_conf.h      \
+ 		man/Makefile                \
+diff --git a/src/Makefile.am b/src/Makefile.am
+index 9e03c78..c36d5cc 100644
+--- a/src/Makefile.am
++++ b/src/Makefile.am
+@@ -17,3 +17,13 @@ if WITH_SELINUX
+ SUBDIRS += \
+ 	selinux
+ endif
++
++sysusersdir = $(prefix)/lib/sysusers.d
++sysusers_DATA = swtpm-sysusers.conf
++
++tmpfilesdir = $(prefix)/lib/tmpfiles.d
++tmpfiles_DATA = swtpm-tmpfiles.conf
++
++EXTRA_DIST = \
++	swtpm-sysusers.conf \
++	swtpm-tmpfiles.conf
+diff --git a/src/swtpm-sysusers.conf.in b/src/swtpm-sysusers.conf.in
+new file mode 100644
+index 0000000..0b02ca4
+--- /dev/null
++++ b/src/swtpm-sysusers.conf.in
+@@ -0,0 +1 @@
++u! @TSS_USER@ - "TPM software stack" @LOCALSTATEDIR@/lib/swtpm-localca
+diff --git a/src/swtpm-tmpfiles.conf.in b/src/swtpm-tmpfiles.conf.in
+new file mode 100644
+index 0000000..afe2d13
+--- /dev/null
++++ b/src/swtpm-tmpfiles.conf.in
+@@ -0,0 +1 @@
++d @LOCALSTATEDIR@/lib/swtpm-localca 0750 @TSS_USER@ root
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch b/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
new file mode 100644
index 0000000..edc0402
--- /dev/null
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
@@ -0,0 +1,29 @@
+From b64b114c9c6941d9729fcc2ad511f108a3affaef Mon Sep 17 00:00:00 2001
+From: Luca Boccassi <luca.boccassi@gmail.com>
+Date: Wed, 7 Oct 2026 08:29:09 +0200
+Subject: [PATCH] swtpm: sync sysuser.d with tpm2-tss
+
+tpm2-tss has shipped a sysusers.d file since 2019 for the tss user:
+
+https://github.com/tpm2-software/tpm2-tss/commit/c43f3c2190eb06e731c5bf7c2849d07f5f8503a5
+
+When two sysusers.d configs have a conflict, the tool raises a warning,
+and the result depends on alphabetic sorting of the config names which
+isn't great. Sync the content: drop the '!', drop the homedir (not used
+anyway) and modify the GECOS string.
+
+Fixes: d318d4046947 ("swtpm: install sysusers.d and tmpfiles.d configs")
+
+Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
+Upstream-Status: Backport [https://github.com/stefanberger/swtpm/commit/b64b114c9c6941d9729fcc2ad511f108a3affaef]
+---
+ src/swtpm-sysusers.conf.in | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/swtpm-sysusers.conf.in b/src/swtpm-sysusers.conf.in
+index 0b02ca4..a9a1779 100644
+--- a/src/swtpm-sysusers.conf.in
++++ b/src/swtpm-sysusers.conf.in
+@@ -1 +1 @@
+-u! @TSS_USER@ - "TPM software stack" @LOCALSTATEDIR@/lib/swtpm-localca
++u @TSS_USER@ - "tss user for tpm2"
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
index 1e91a91..50d2cfc 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
@@ -8,7 +8,10 @@ SECTION = "apps"
 DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpms json-glib"
 
 SRCREV = "32b5a0575991a73398de9749d63cafd847008af2"
-SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
+SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https \
+           file://0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch \
+           file://0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch \
+          "
 PE = "2"
 
 PARALLEL_MAKE = ""
@@ -40,6 +43,10 @@ USERADD_PARAM:${PN} = "--system -g ${TSS_GROUP} --home-dir / \
 
 PACKAGE_BEFORE_PN = "${PN}-cuse"
 FILES:${PN}-cuse = "${bindir}/swtpm_cuse"
+FILES:${PN} += " \
+    ${libdir}/sysusers.d/swtpm-sysusers.conf \
+    ${libdir}/tmpfiles.d/swtpm-tmpfiles.conf \
+"
 
 INSANE_SKIP:${PN}   += "dev-so"
 
-- 
2.43.0

