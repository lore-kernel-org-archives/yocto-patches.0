Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2576.1794370867623770736
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m32428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 17/34] configure: Fix --disable-* options
Date: Tue, 10 Nov 2026 22:20:45 -0600
Message-Id: <1794370862-30908-18-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5276
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

configure turns --disable-<option> into --enable-<option>=no before
matching options, but used ${arg%--disable-}, which removes a suffix,
instead of ${arg#--disable-}, which removes the prefix.  Every
--disable-* option became --enable---disable-<option>=no, which matched
nothing, so it was ignored with an "Unrecognized option" warning.

Remove the prefix, so --disable-force-async, --disable-profiling,
--disable-xattr, --disable-xattrdb and --disable-memory-db take effect,
and --disable-epoll fails with the intended error.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 315bcd0..e659370 100755
--- a/configure
+++ b/configure
@@ -58,7 +58,7 @@ for arg
 do
     case "$arg" in
     --disable-*)
-        arg="--enable-${arg%--disable-}=no"
+        arg="--enable-${arg#--disable-}=no"
 	;;
     esac
     case "$arg" in
-- 
1.8.3.1

