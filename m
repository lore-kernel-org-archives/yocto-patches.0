Return-Path: <wuxiaotian@loongson.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A632C282D1
	for <webhook@archiver.kernel.org>; Sun,  9 Mar 2025 06:00:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mx.groups.io with SMTP id smtpd.web10.10950.1741500055467681158
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Mar 2025 22:00:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: loongson.cn, ip: 114.242.206.163, mailfrom: wuxiaotian@loongson.cn)
Received: from loongson.cn (unknown [192.168.100.1])
	by gateway (Coremail) with SMTP id _____8Axz3OVLs1nPJqPAA--.48070S3;
	Sun, 09 Mar 2025 14:00:53 +0800 (CST)
Received: from localhost.localdomain (unknown [192.168.100.1])
	by front1 (Coremail) with SMTP id qMiowMBxb8eSLs1nJr0_AA--.40372S3;
	Sun, 09 Mar 2025 14:00:52 +0800 (CST)
From: Xiaotian Wu <wuxiaotian@loongson.cn>
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
Subject: [pseudo] [PATCH 1/3] pseudo_wrappers.c: Add support for LoongArch64
Date: Sun,  9 Mar 2025 14:00:37 +0800
Message-ID: <20250309060039.454124-2-wuxiaotian@loongson.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309060039.454124-1-wuxiaotian@loongson.cn>
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8eSLs1nJr0_AA--.40372S3
X-CM-SenderInfo: 5zx0xtprwlt0o6or00hjvr0hdfq/1tbiAgEQCGfMz2ABsQALsk
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyrAr15KF1UGrWkKFW8Zrc_yoWrCw1rpF
	W8Ary3tr13AF17Xr9Yya1j9rnagr1xJ3WYkrWSyw47CFs5G397XFW8KrW0y34fGrykG3Wf
	Ja4kW3WqgF4DKFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 09 Mar 2025 06:00:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1167

Since these symbols do not exist in LoongArch's libc.so, they
need to be remapped, and the first "ver" function parameter
does not exist in the mapped function.

__fxstat __fxstat64 __fxstatat __fxstatat64 __lxstat __lxstat64
__xmknod __xmknodat __xstat __xstat64

Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
---
 pseudo_wrappers.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 9ae1200..b54b0c3 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -122,6 +122,64 @@ pseudo_reinit_libpseudo(void) {
 	_libpseudo_init();
 }
 
+#if defined(__loongarch_lp64)
+#define LOAD_REAL_SYMBOL(name, symbol) \
+    pseudo_real_##name = dlsym(RTLD_NEXT, symbol); \
+    real_##name = pseudo_##name
+
+static int (*pseudo_real___fxstat)(int fd, struct stat *buf) = NULL;
+static int (*pseudo_real___fxstat64)(int fd, struct stat64 *buf) = NULL;
+static int (*pseudo_real___fxstatat)(int dirfd, const char *path, struct stat *buf, int flags) = NULL;
+static int (*pseudo_real___fxstatat64)(int dirfd, const char *path, struct stat64 *buf, int flags) = NULL;
+static int (*pseudo_real___lxstat)(const char *path, struct stat *buf) = NULL;
+static int (*pseudo_real___lxstat64)(const char *path, struct stat64 *buf) = NULL;
+static int (*pseudo_real___xmknod)(const char *path, mode_t mode, dev_t *dev) = NULL;
+static int (*pseudo_real___xmknodat)(int dirfd, const char *path, mode_t mode, dev_t *dev) = NULL;
+static int (*pseudo_real___xstat)(const char *path, struct stat *buf) = NULL;
+static int (*pseudo_real___xstat64)(const char *path, struct stat64 *buf) = NULL;
+
+static int pseudo___fxstat(int ver __attribute__((unused)), int fd, struct stat *buf)
+{
+	return pseudo_real___fxstat(fd, buf);
+}
+static int pseudo___fxstat64(int ver __attribute__((unused)), int fd, struct stat64 *buf)
+{
+	return pseudo_real___fxstat64(fd, buf);
+}
+static int pseudo___fxstatat(int ver __attribute__((unused)), int dirfd, const char *path, struct stat *buf, int flags)
+{
+	return pseudo_real___fxstatat(dirfd, path, buf, flags);
+}
+static int pseudo___fxstatat64(int ver __attribute__((unused)), int dirfd, const char *path, struct stat64 *buf, int flags)
+{
+	return pseudo_real___fxstatat64(dirfd, path, buf, flags);
+}
+static int pseudo___lxstat(int ver __attribute__((unused)), const char *path, struct stat *buf)
+{
+	return pseudo_real___lxstat(path, buf);
+}
+static int pseudo___lxstat64(int ver __attribute__((unused)), const char *path, struct stat64 *buf)
+{
+	return pseudo_real___lxstat64(path, buf);
+}
+static int pseudo___xmknod(int ver __attribute__((unused)), const char *path, mode_t mode, dev_t *dev)
+{
+	return pseudo_real___xmknod(path, mode, dev);
+}
+static int pseudo___xmknodat(int ver __attribute__((unused)), int dirfd, const char *path, mode_t mode, dev_t *dev)
+{
+	return pseudo_real___xmknodat(dirfd, path, mode, dev);
+}
+static int pseudo___xstat(int ver __attribute__((unused)), const char *path, struct stat *buf)
+{
+	return pseudo_real___xstat(path, buf);
+}
+static int pseudo___xstat64(int ver __attribute__((unused)), const char *path, struct stat64 *buf)
+{
+	return pseudo_real___xstat64(path, buf);
+}
+#endif
+
 static void
 pseudo_init_one_wrapper(pseudo_function *func) {
 	int (*f)(void) = (int (*)(void)) NULL;
@@ -185,6 +243,18 @@ pseudo_init_wrappers(void) {
 	pseudo_real_fork = dlsym(RTLD_NEXT, "fork");
 	pseudo_real_execv = dlsym(RTLD_NEXT, "execv");
 
+#if defined(__loongarch_lp64)
+	LOAD_REAL_SYMBOL(__fxstat, "fstat");
+	LOAD_REAL_SYMBOL(__fxstat64, "fstat64");
+	LOAD_REAL_SYMBOL(__fxstatat, "fstatat");
+	LOAD_REAL_SYMBOL(__fxstatat64, "fstatat64");
+	LOAD_REAL_SYMBOL(__lxstat, "lstat");
+	LOAD_REAL_SYMBOL(__lxstat64, "lstat64");
+	LOAD_REAL_SYMBOL(__xmknod, "mknod");
+	LOAD_REAL_SYMBOL(__xmknodat, "mknodat");
+	LOAD_REAL_SYMBOL(__xstat, "stat");
+	LOAD_REAL_SYMBOL(__xstat64, "stat64");
+#endif
 	/* Once the wrappers are setup, we can now use open... so
 	 * setup the logfile, if necessary...
 	 */
-- 
2.48.1


